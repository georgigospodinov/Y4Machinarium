#!/usr/bin/env bash

# Put the path to the Savile Row executable in this constant.
readonly CONSTRAINT_SOLVER="../savile_row/savilerow"
readonly SOLVE="-run-solver"
readonly MODEL="machinarium.eprime"
readonly FLAGS="-O3"
readonly DEFAULT_INSTANCE="instance2x2_a.param"
instance=${DEFAULT_INSTANCE}

# Check if there is an argument.
if [[ $# -eq 1 ]]
    then instance=$1
fi

solution=${instance}".solution"
echo "Deleting old solution..."
rm -rf ${solution}

# Construct the command to run the solver with the model and an instance.
command=${CONSTRAINT_SOLVER}" "${MODEL}" "${instance}" "${SOLVE}" "${FLAGS}
# Execute the command.
${command}

# Delete extra files
echo "Deleting .infor and .minion files..."
rm -rf ${instance}".infor" ${instance}".minion"

echo ""
if [[ -f ${solution} ]]
then
    echo "Found Solution"
    tail -n +6 ${solution}
    echo ""
    echo "in"
    echo ""
    tail -n +3 ${instance}
else echo "No Solution"
fi