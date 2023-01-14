#!/bin/sh
function try()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function throw()
{
    exit $1
}

function catch()
{
    export ex_code=$?
    (( $SAVED_OPT_E )) && set +e
    return $ex_code
}

function throwErrors()
{
    set -e
}

function ignoreErrors()
{
    set +e
}

try
(
    eval npx create-react-app $1 --template typescript
    cd $1
    eval npm init @eslint/config
    eval npm install --save-dev --save-exact prettier
    eval touch .prettierrc
    echo '{ "singleQuote": true, "trailingComma": "all", "printWidth": 120, "tabWidth": 2 }' > .prettierrc
) 
catch || {
    case $ex_code in
        0)  echo "Success"
            ;;
        *)  echo "Error: $ex_code"
            ;;
    esac
}
