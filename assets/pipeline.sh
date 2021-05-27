#!/bin/bash
# Pipeline

# Subrotine to handle errors
function handle_error {
    if [ $? -ne 0 ] # Check if previous command status code is not 0
    then
        echo 'pipeline -> fail ->' $1 # Outout an error message
        exit 1 # Exit pipeline with status 1
    fi
}

# Update modules
# npm install

# TODO: Perform static tests

# Build and Run application
npm run build
handle_error 'npm run build'
echo 'pipeline -> pass -> Application build successful!'

# TODO: Perform Jest tests

if [ -z "$1" ] # If no commit message was supplied, don't deploy
then
    echo 'pipeline -> info -> No commit message supplied, not deploying!'
    exit 0
fi

# Add and commit changes to version control
COMMIT_PATTERN="^\d+(.\d+)*\s(Add|Update|Fix)\s.*$"
COMMIT_PATTERN="^(Add|Update|Fix)$"
if [[ $1 =~ $COMMIT_PATTERN ]]
then
    if [[ $1 =~ "^\d+(.\d+)*" ]]
    then
        VERSION=$BASH_REMATCH[0]
    fi
    echo 'pipeline -> info -> Preparing to deploy version ' $VERSION ' ...'
    echo 'pipeline -> info -> Adding files...'
    # git add .
    echo 'pipeline -> info -> Commiting changes...'
    # git commit -m 'COMPX341-21A-V' $1
    handle_error 'git commit -m $1'
    echo 'pipeline -> info -> Deploying...'
    # git push origin main
    handle_error 'git push origin main'

    echo 'pipeline -> pass -> Deployment completed successfully!'
else
    echo 'pipeline -> fail -> Commit message does not adhere to project convention: <version> Add|Update|Fix <change>'
    exit 1
fi