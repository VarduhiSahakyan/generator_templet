#!/bin/bash
# Include utils.sh
. utils.sh

#
# Must be run in mysql docker image
#
TMP_DIR="/tmp/acs-hub-configuration"
HUB_CONFIGURATION_DIRECTORY="hub-configuration"
ACS_CONFIGURATION_DIRECTORY="acs-configuration"

SCRIPT_PATH=$(dirname "$0")

# MySQL settings
MYSQL_ROOT_PASSWORD="pistache"

# Execute SQL script
executeSqlFile() {

logDebug "Executing SQL File $1:" " . "
{
out=$(cat $1 | mysql --defaults-extra-file=${SCRIPT_PATH}/config.cnf -s 2> /dev/fd/3)
err=$(cat<&3)
} 3<<EOF
EOF

logDebug "$out" "   - "
logError "$err" "   - "
}

# Execute SQL script
executeSqlCmd() {

logDebug "Executing SQL command '$1':" " . "
{
out=$(mysql --defaults-extra-file=${SCRIPT_PATH}/config.cnf -e "$1" -s 2> /dev/fd/3)
err=$(cat<&3)
} 3<<EOF
EOF

logDebug "$out" "  . "
logError "$err" "  . "
}

# Extract component artifacts to TMP_DIR
extractArtifacts() {

    logInfo "Extract artifacts for $1 ..."
    component=$1
    artifacts_path="target"

    find="$(find $component/$artifacts_path -type f -name *.zip)"

    if [[ -z ${find} ]]; then
        logError "Unable to find artifacts in $component/$artifacts_path"
        exitScript
    fi

    for artifact in ${find}; do

        file=$(basename -- "$artifact")
        filename=${file%.*}
        artifact_tmp_dir="$TMP_DIR/$filename"

        logDebug " . Extracting to $artifact_tmp_dir"
        mkdir -p ${artifact_tmp_dir}
        unzip -oq ${artifact} -d ${artifact_tmp_dir}

    done
    logSuccess "Done"
}

# Execute script directory : execute all *.sql files
executeScriptDirectory() {

    logInfo "Execute directory script: $1"

    find="$(ls $1/$2)"
    if [[ -z ${find} ]]; then
        logError "Unable to find script files in $1/$2"
        exitScript
    fi

    for sqlFile in ${find}; do
        executeSqlFile ${sqlFile};
    done
}

# Execute script sub-directories : execute all *.sql files inside sub-directories
executeScriptSubDirectories() {

    logInfo "> Execute all subdirectories script in: $1"

    find="$(find $1 -maxdepth 1 -mindepth 1 -type d)"
    if [[ -z ${find} ]]; then
        logError "Unable to find subdirectories in  $1"
        exitScript
    fi

    for subDirectory in ${find}; do
        executeScriptDirectory ${subDirectory} $2
    done
}

main() {
  if [[ $# -gt 2 ]]
  then
    check $1 $2 $3 $4
  else
    usage
  fi
}

check(){
  cd ${SCRIPT_PATH}

  startMySQL
  waitMySQL

  installDependencies

  instance=$2
  ENV=$3

  if [[ $1 == "HUB" ]];
  then
      component=${HUB_CONFIGURATION_DIRECTORY}

      extractArtifacts ${component}
      executeScriptDirectory "$TMP_DIR/$component-platform" "[1-9]*.sql"

      executeScriptDirectory "$TMP_DIR/$component-$instance-$ENV" "[1-9]*.sql"
      executeScriptSubDirectories "$TMP_DIR/$component-$instance-$ENV" "[1-9]*.sql"

      if [[ $4 == "--rollback" ]]; then

        executeScriptSubDirectories "$TMP_DIR/$component-$instance-$ENV" "_rollback/[1-9]*.sql"

      fi

      logInfo "~ Cleaning database ..."
      executeSqlCmd "DROP DATABASE IF EXISTS H0B_ASR;"
      executeSqlCmd "DROP DATABASE IF EXISTS H0B_RBA;"
      executeSqlCmd "DROP DATABASE IF EXISTS H5B_CREPO;"
      logDebug "~ Database cleaned"

      exitScript

  else
      component=${ACS_CONFIGURATION_DIRECTORY}

      extractArtifacts ${component}

      if [[ ${instance} == "U0P" ]]; then
        executeScriptSubDirectories "$TMP_DIR/$component-$instance" "*.sql"
      else
         executeScriptSubDirectories "$TMP_DIR/$component-$instance-$ENV" "*.sql"
      fi

      # TODO Drop the ACS tables

      exitScript
  fi
}

usage() {
    echo -e "\nACS HUB Configuration Check Tool\n"
    echo -e "Usage:"
    echo -e "-------\n"
    echo -e "# Test scripts with count errors exit code"
    echo -e "> $0 <COMPONENT> <INSTANCE> <ENV>\n"
    echo -e " - COMPONENT one of HUB or ACS"
    echo -e " - INSTANCE the target instance (H5B, H6B, ...)"
    echo -e " - ENV one of dev, rci, rce or prod"
    echo -e ""
    echo -e "Example: $0 HUB H5B rce --rollback"
    echo -e ""
    ((exit_code++))
    exitScript
}

startMySQL() {
  if service mysql status | grep -q "not running"; then
    export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
    logInfo "Starting MySQL ..."
    /usr/local/bin/docker-entrypoint.sh mysqld > /dev/null 2>&1 &
  fi
}

waitMySQL() {
    count=0
    logDebug "Fix credentials" " . "
    chmod 0444 ${SCRIPT_PATH}/config.cnf
    while ! mysql --defaults-extra-file=${SCRIPT_PATH}/config.cnf -e "show databases;" > /dev/null 2>&1; do
        ((count++))
        logDebug "waiting MySQL $count" " . "
        sleep 2
        if [[ ${count} -eq 15 ]]; then
          logError ">>>> MySQL unreachable"
          exitScript
        fi
    done
    logSuccess "MySQL started"
}

installDependencies() {
  if [[ ! $(which unzip) ]]; then
    logInfo "Installing dependencies"

    logDebug "Updating apt" " ."
    apt-get update > /dev/null || logError "Failed to update apt-get"

    logDebug "Installing unzip" " ."
    apt-get install -y unzip > /dev/null || logError "Failed to install unzip"

    if [[ ${exit_code} -gt 0 ]]; then
      exitScript
    fi
  fi
  logSuccess "Dependencies installed"
}

main $*