#functions for h1

#get the inscope rules from the csv file obtained from program's detail
#This can be done with HackerOne's API using structured_scopes
H1_getScopefromCsv()
{
    input=$1
    if [[ -z "$input" ]]; then
        echo "Use ${FUNCNAME[0]} URL or csv file"
        return 1
    fi
    # Check if the input matches the pattern of a typical URL
    url_regex='^(http|https)://.*$'

    if [[ $input =~ $url_regex ]]; then
        #echo "wget $input"
        program=$(echo $input | sed 's/.*teams\/\([^\/]*\)\/assets.*/\1/')
        #echo "program $program"
        #wget -q "$input" -O "$program-scope.csv"
        curl -s $input | awk -F',' '$5 == "true" {print}' |grep 'URL\|WILDCARD'|getField 1 ","|sed 's/https:\/\///g; s/http:\/\///g'|tr -d '/'|flatten
    else
        #checking if file exists 
        if [[ -f "$input" ]]; then
            #echo "$input exists."
            awk -F',' '$4 == "true" {print}' "$input"|grep 'URL\|WILDCARD'|getField 1 ","|sed 's/https:\/\///g; s/http:\/\///g'|tr -d '/'| flatten
        else
            echo "$input not found!"
        fi
    fi
}

#H1_addInscopeToProgram()
#{
    
#}
