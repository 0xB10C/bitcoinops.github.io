#!/bin/sh

## Finds newly added or modifyed PNG files in the repository and checks if each file is optimized.
## If not optimized it fails with a error code 1

CHANGEDFILES=$(git diff --name-only --diff-filter=AM $TRAVIS_COMMIT_RANGE)

for FILE in $CHANGEDFILES; do
	if echo $FILE | grep -q ".png$"; then 
		echo checking $FILE
		OPTIPNGOUTPUT=$(optipng -simulate "$FILE" 2>&1)
	    	if ! echo $OPTIPNGOUTPUT | grep -q "is already optimized"; then
        		echo "The file $FILE is not optimized. To optimize use 'optipng -o7 $FILE'."
        		exit 1
    		fi
	fi
done
