#!/usr/bin/env bash

# Put the path to the Savile Row executable in this constant.
readonly CONSTRAINT_SOLVER="../savile_row/savilerow"
readonly SOLVE="-run-solver"
readonly MODEL="compact.eprime"
readonly FLAGS=""
readonly INSTANCES_FOLDER="./*"
readonly ERROR_LOG="log.txt"
readonly STDOUT_LOG="/dev/null"

function solve {
    # ${1} is the file to solve

    # Ignore files that do not end with .param
    if [[ ${1} != *.param ]]
        then return
    fi

    # Delete old solution
    solution=${1}".solution"
    rm -rf ${solution}

    # Construct the command to run the solver with the model and an instance.
    command=${CONSTRAINT_SOLVER}" "${MODEL}" "${1}" "${SOLVE}" "${FLAGS}
    # And run the command. Write the filename in the log files.
    echo ${1} >> ${STDOUT_LOG}
    echo ${1} >> ${ERROR_LOG}
    ${command} 1> ${STDOUT_LOG} 2>>${ERROR_LOG}
    echo "======" >> ${STDOUT_LOG}
    echo "======" >> ${ERROR_LOG}

    # Delete extra files
    rm -rf ${1}".infor" ${1}".minion"

    # Print presence of solution.
    if [[ -f ${solution} ]]
        then echo ${1} "solved"
        else echo ${1} "------"
    fi
}

echo "Solving all instances..."
echo "Error output log" > ${ERROR_LOG}

for filename in ${INSTANCES_FOLDER}
do
    solve ${filename}
done