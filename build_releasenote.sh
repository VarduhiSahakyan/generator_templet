#!/bin/sh

NOTE_FILENAME="release_note.md"

NOTE_TITLE="ACS / HUB Configuration"

JIRA_BASE_URL="https://jira.itsm.atosworldline.com/browse/"
JIRA_ID_PATTERN="\([0-9A-Z]\{5,\}-[0-9]\+\)"

GIT_GET_TAGS_CMD=$(git for-each-ref --sort=-taggerdate --format '%(refname:short) %(taggerdate:short)' refs/tags)
GIT_GET_COMMITS_CMD=$(git log --no-merges --pretty="%s")

RELEASE_SEPARATOR="\n---------------\n"

echo -e "# $NOTE_TITLE\n" > $NOTE_FILENAME

#echo -e "\n## Tags\n" >> $NOTE_FILENAME
#
#echo -e "$GIT_GET_TAGS_CMD" \
#  | sed "s#(?<=\\(|\\G)([^)(\\.]+).(?=[^)(]*\\))#\1#g" \
#  | sed "s#\$#  #g" \
#  >> $NOTE_FILENAME

echo -e "\n## Release note\n" >> $NOTE_FILENAME

echo -e "\n## Current\n" >> $NOTE_FILENAME

echo -e "$GIT_GET_COMMITS_CMD" \
 | sed "s#$JIRA_ID_PATTERN#[\1]($JIRA_BASE_URL\1)#g" \
 | sed "s#\(Release [^ ]*\)#$RELEASE_SEPARATOR\#\#\# **\1**  #g" \
 | sed "s#\(Snapshot [^ ]*\)#_\1_  #g" \
 | sed "s#\$#  #g" \
  >> $NOTE_FILENAME