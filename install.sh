#!/bin/bash
#
# Copyright (C) Rodrigo Villamil Perez 2018
# Fichero: create-definitions.sh
# Autor: Rodrigo
# Fecha: 23/12/18
#

# CONSTANTS
TOOLS_DIR=`pwd`
PROJECTS=`/bin/ls -d Frameworks/*`
FRAMEWORKS_DIR="Frameworks"
INSTALL_FRAMEWORKS_DIR="/Library/Frameworks"

ITUNES_PROJECT_DIR="${FRAMEWORKS_DIR}/iTunes/iTunesScripting/"

#
# ${1}: app name
#
function createHeaderFiles() {
    app_name="${1}"
    output="${FRAMEWORKS_DIR}/${app_name}/${app_name}Scripting"

    echo "* Creating objective-C headers for app '${app_name}' in '${output}' directory ..."
    cd ${output} > /dev/null 2>&1
    sdef /Applications/${app_name}.app > ${app_name}.sdef
    sdp -fh --basename ${app_name} ${app_name}.sdef
    cd - > /dev/null 2>&1

    return 0
}

#
# ${1}: app name
#
function createHeaderSwiftFiles() {  
    app_name="${1}"
    output="${FRAMEWORKS_DIR}/${app_name}/${app_name}Scripting"
    echo "* Creating swift headers with for app '${app_name}' in '${output}' directory ..."
    cd ${output} > /dev/null 2>&1
    python ${TOOLS_DIR}/sbhc.py ${app_name}.h &&
    python ${TOOLS_DIR}/sbsc.py ${app_name}.sdef
    cd - > /dev/null 2>&1
  
    return 0
}

#
# ${1}: app name
#
function build () {
    app_name="${1}"
   
    echo "* Building project '${app_name}' with xcodebuild tools ..'"
    cd "${FRAMEWORKS_DIR}/${app_name}" > /dev/null 2>&1
    rm -rf build
    xcodebuild
    res=${?}
    cd - > /dev/null 2>&1
    
    return ${res}
}

#
# ${1}: app name
#
function install () {
    app_name="${1}"
   
    echo "* Install project '${app_name}' in ${INSTALL_FRAMEWORKS_DIR}'"
    cd "${FRAMEWORKS_DIR}/${app_name}" > /dev/null 2>&1
    sudo rm -rf "/Library/Frameworks/${app_name}Scripting.framework"
    sudo mv "build/Release/${app_name}Scripting.framework" ${INSTALL_FRAMEWORKS_DIR} 
    res=${?}
    cd - > /dev/null 2>&1
    
    return ${res}
}

#
# -- Main
#
createHeaderFiles "iTunes" &&
createHeaderSwiftFiles "iTunes" &&
build "iTunes" &&
install "iTunes"