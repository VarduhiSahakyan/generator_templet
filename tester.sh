#!/bin/sh

#
# First launch vagrant for the project and connect to it (vagrant up + vagrant ssh)
# Then in /vagrant launch ./tester.sh with arguments
# example: "./tester.sh HUB H5B dev"
# or only to start the mysql docker container: "./tester.sh up"
#
TMP_DIR="/tmp/acs-hub-configuration"
HUB_CONFIGURATION_DIRECTORY="hub-configuration"
ACS_CONFIGURATION_DIRECTORY="acs-configuration"

ACS_INSTANCE_DIRECTORY="$ACS_CONFIGURATION_DIRECTORY/src/main/resources/templates/_instance"

# MySQL settings
MYSQL_ROOT_PASSWORD="pistache"
MYSQL_USER="h0b"
MYSQL_PASSWORD="chocolat"
MYSQL_DATABASE="h0b"

LOGFILE=$(date "+%y%m%d%H%M%S")".log"

RED='\033[0;31m'
GREEN='\033[0;32m'
GREY='\033[1;30m'
NC='\033[0m' # No Color

CURRENT_ACS_OBJECT_CODE=""
CURRENT_ISSUER_ID=""

up() {
    container=$(docker ps | grep mysql)
    if [[ -z "$container" ]]; then
        echo "starting mysql container"
        docker-compose up -d
        # TODO wait for container to start?
    fi
}

executeMySqlFile() {
    sqlFile="$1"
    cat "$sqlFile" | docker exec -i vagrant_mysql_1 mysql -h localhost -P 3306 -u root --password="$MYSQL_ROOT_PASSWORD" -s >> log/"$LOGFILE" 2>&1
}

executeMySqlCmd() {
    sqlCmd="$1"
    docker exec vagrant_mysql_1 mysql -h localhost -P 3306 -u root --password="$MYSQL_ROOT_PASSWORD" -e "$sqlCmd" -s 2>> log/"$LOGFILE"
}

# Extract component artifacts to TMP_DIR
extractArtifacts() {

    echo -e "Extracting artifacts for $1 ..."

    component=$1
    artifacts_path="target"

    for artifact in `find "$component/$artifacts_path" -type f -name "*.zip"`; do

        file=$(basename -- "$artifact")
        filename=${file%.*}
        artifact_tmp_dir="$TMP_DIR/$filename"

        echo -e ". Extracting to $artifact_tmp_dir"

        mkdir -p "$artifact_tmp_dir"
        unzip -oq "$artifact" -d "$artifact_tmp_dir"
    done
}

# Execute script directory : execute all *.sql files
executeScriptDirectory() {

    if [[ -d "$1" ]]; then
        echo -e "\\n${GREY}Execute directory script : $1 ${NC}"
        for sqlFile in `ls $1/*.sql`; do
            executeMySqlFile "$sqlFile";
        done
    else
        echo -e "\\n${GREY}ignoring $1 (unexisting) ${NC}"
    fi
}

# Execute script sub-directories : execute all *.sql files inside sub-directories
executeScriptSubDirectories() {

    instance=$(basename --$1)
    echo -e "\\nInstance [ $instance ($CURRENT_ACS_OBJECT_CODE) ]"

    for subDirectory in `find $1 -type d -maxdepth 1 -mindepth 1`; do
        executeScriptDirectory "$subDirectory"
        checkHubBank "$instance" "$subDirectory"
        executeScriptDirectory "$subDirectory"/_rollback
        checkHubBank "$instance" "$subDirectory" false
    done
}

# Checks HUB Bank
checkHubBank() {
    instance="$1"
    bank=$(basename -- $2)

    getIssuerId "$2"

    if [[ -z "$3" ]]; then
        checkOK="true"
    else
        checkOK="$3"
    fi

    echo " . Checking Bank $bank ($CURRENT_ISSUER_ID) ..."
    checkHubBankASRService "$CURRENT_ACS_OBJECT_CODE" "$CURRENT_ISSUER_ID" "$checkOK"
}

checkHubBankASRService() {
    service=$(executeMySqlCmd "SELECT s.* FROM H0B_ASR.SERVICE s WHERE s.label='ACS_$1-$2'")

    if [[ -z "$service" ]]; then
        if [[ "$3" = "true" ]]; then 
            itemKO "$2 not in ASR"
        else
            itemOK "$2 not in ASR"
        fi
    else
        if [[ "$3" = "true" ]]; then 
            itemOK "$2 in ASR"
        else
            itemKO "$2 in ASR"
        fi
    fi
}

itemOK() {
    echo -e "\\t[ ${GREEN}OK${NC} ] $1"
}

itemKO() {
    echo -e "\\t[ ${RED}KO${NC} ] $1"
}

getACSObjectCode() {
    asrfile_search_pattern="$1/3-*ASR.sql"
    asrFile=$(ls $asrfile_search_pattern)
    CURRENT_ACS_OBJECT_CODE=$(sed -n "s/.*@acs_object_code='\(.*\)'.*/\1/p" "$asrFile")
}

getIssuerId() {
    asrfile_search_pattern="$1/*ASR*.sql"
    asrFile=$(ls $asrfile_search_pattern)
    CURRENT_ISSUER_ID=$(sed -n "s/.*@bank_issuer_id='\(.*\)'.*/\1/p" "$asrFile")
}

main() {
    echo -e "${NC}"
    if [[ $# -eq 0 ]]
    then
        usage
        exit 1
    elif [[ "$1" == "up" ]]
    then
        up
    elif [[ $# -eq 3 ]]
    then
        launchTest "$1" "$2" "$3"
    else
        usage
    fi
    echo -e "${NC}"
}

testAcs() {
    component="$ACS_CONFIGURATION_DIRECTORY"
    instance="$1"
    ENV="$2"
    
    extractArtifacts "$component"

    executeScriptDirectory "$ACS_INSTANCE_DIRECTORY/$instance"
    
    # test all issuers script
    part="_ALL_ISSUERS_"
    executeMySqlFile "$TMP_DIR/$component-$instance-$ENV/$instance$part$ENV.sql"
    # TODO test something?
    
    # test all issuers rollback
    part="_ROLLBACK_ALL_ISSUERS_"
    executeMySqlFile "$TMP_DIR/$component-$instance-$ENV/$instance$part$ENV.sql"
    # TODO test something?
    
    # TODO test each individual scripts instead of the "all issuers"
    
    echo -e "${GREY}~ Cleaning database${NC}"
    executeMySqlCmd "DROP DATABASE IF EXISTS U1M_ACS_MONITOR;"
    executeMySqlCmd "DROP DATABASE IF EXISTS U5B_ACS_BO;"
    executeMySqlCmd "DROP DATABASE IF EXISTS U5B_ACS_FO;"
    executeMySqlCmd "DROP DATABASE IF EXISTS U5B_ACS_WS;"
    echo -e "${GREY}~ Database cleaned${NC}"
}

testHub() {
    component="$HUB_CONFIGURATION_DIRECTORY"
    instance="$1"
    ENV="$2"
    
    extractArtifacts "$component"

    executeScriptDirectory "$TMP_DIR/$component-platform"

    getACSObjectCode "$TMP_DIR/$component-$instance-$ENV"

    executeScriptDirectory "$TMP_DIR/$component-$instance-$ENV"

    executeScriptSubDirectories "$TMP_DIR/$component-$instance-$ENV"

    echo -e "${GREY}~ Cleaning database${NC}"
    executeMySqlCmd "DROP DATABASE IF EXISTS H0B_ASR;"
    executeMySqlCmd "DROP DATABASE IF EXISTS H0B_RBA;"
    executeMySqlCmd "DROP DATABASE IF EXISTS H5B_CREPO;"
    echo -e "${GREY}~ Database cleaned${NC}"
}

launchTest(){
    echo -e "${GREY}~ Launch test $1 $2 $3 ${NC}"
    up
    if [[ $1 == "HUB" ]];
    then
        testHub "$2" "$3"
    else
        testAcs "$2" "$3"
    fi
   
}

usage() {
    echo -e "ACS-HUB Configuration Tool"
    echo -e ""
    echo -e "Usage:"
    echo -e "-------\\n"
    echo -e "# Start MySQL server"
    echo -e "> ./tester.sh up\\n"
    echo -e "# Test scripts"
    echo -e "> ./tester.sh COMPONENT INSTANCE ENV\\n"
    echo -e "\\t - COMPONENT one of HUB or ACS"
    echo -e "\\t - INSTANCE the target instance (H5B, H6B, ...)"
    echo -e "\\t - ENV one of dev, rci, rce or prod"
    echo -e ""
    echo "Example: ./tester.sh HUB H5B rce"
    echo -e ""
}

main $*