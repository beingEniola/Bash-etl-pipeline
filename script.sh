#!/bin/bash

# Exit immediately if a command fails
set -e

# define variables
raw_dir="raw"
transformed_dir="Transformed"
load_dir="Gold"

data_file="annual-enterprise-survey-2023-financial-year-provisional.csv"
output_file="2023_year_finance.csv"

# define URL variable as an environment variable
export FILE_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

# Define variables for the Colors

GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

# Define Logging Functions
success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# define function to extract file
extract(){
    # create raw directory if it doesn't exist
    mkdir -p "$raw_dir"

    # download csv file
    curl -s -o "$raw_dir/$data_file" "$FILE_URL"

    # check if file was saved in raw folder successfully
    if [ -f "$raw_dir/$data_file" ];
        then 
            success "file succesfully saved to raw folder"
        else
            error "file was not saved to raw folder"
    fi
}



# define function to transform data
transform(){
    # create transformed directory if it doesn't exist
    mkdir -p "$transformed_dir"

    # transform data
    data="$raw_dir/$data_file"

    # rename column Variable_code to variable_code
    sed -i '1 s/Variable_code/variable_code/' $data

    #  select only the following columns: year, Value, Units, variable_code
    awk 'BEGIN {OFS=","}
    NR == 1 {
        for (i = 1; i <= NF; i++) {
            if ($i == "Year") {
                year_col = i
            }

            if ($i == "Value") {
                value_col = i
            }

            if ($i == "Units") {
                units_col = i
            }

            if ($i == "variable_code") {
                variable_code_col = i
            }
        }

        print "year,Value,Units,variable_code"
        next
    }

    {
        print $year_col "," $value_col "," $units_col "," $variable_code_col
    }
    ' $data > "$transformed_dir/$output_file"

    # confirm that the file was saved in transforned folder successfully
    if [ -f "$transformed_dir/$output_file" ];
        then 
            success "file succesfully saved to transformed folder"
        else
            error "file was not saved to transformed folder"
    fi

}

# define load function
load(){
    # create gold directory if it doesn't exist
    mkdir -p "$load_dir"

    # load data
    cp "$transformed_dir/$output_file" "$load_dir/$output_file"

    # confirm that the file was saved in gold folder successfully
    if [ -f "$load_dir/$output_file" ];
        then 
            success "file succesfully saved to gold folder"
        else
            error "file was not saved to gold folder"
    fi

}

extract
transform
load