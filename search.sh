#!/usr/bin/env bash
#
#==============================================================================
# FILE: search.sh
#
# USAGE: ./search.sh "<file_pattern>" "<search_string>"
#
# DESCRIPTION:
#     This script searches through all files matching the specified shell
#     wildcard pattern for occurrences of the provided search string. If
#     matches are found in a file, the script prints the file's path along with
#     the number of occurrences of that string in the file. If no matches are
#     found, it does not print anything for that file.
#
# NOTE:
#     1. The pattern and search string must be quoted appropriately if they
#        contain characters the shell may interpret (e.g., spaces, special
#        wildcard symbols).
#     2. The script uses grep with the -F and -o options:
#          -F treats the search string as a literal (rather than a pattern).
#          -o ensures each matched string is printed, so we can accurately
#            count occurrences even if that string appears multiple times
#            on the same line.
#     3. This script exits with an error if the wrong number of arguments
#        is provided or if the specified pattern matches no files.
#
# REQUIREMENTS:
#     bash, grep, wc
#
# AUTHOR: ChatGPT
# VERSION: 1.0
# CREATED: 2023-10
#==============================================================================

###############################################################################
# Safety measures and error handling
###############################################################################
# -e : Exit immediately if a command returns a non-zero status.
# -u : Treat unset variables as an error and exit immediately.
# -o pipefail : Return exit status of the last command that had a non-zero exit
#     status in a pipeline.
set -euo pipefail

###############################################################################
# Usage: Display usage information if arguments are missing or incorrect.
###############################################################################
function usage() {
  echo "Usage: $0 \"<file_pattern>\" \"<search_string>\""
  echo "Example: $0 \"./logs/*.log\" \"CRITICAL_ERROR\""
  exit 1
}

###############################################################################
# Main script
###############################################################################
# 1) Validate argument count
if [ $# -ne 2 ]; then
  usage
fi

# 2) Capture arguments
pattern="$1"
search_string="$2"

# 3) Expand the file pattern
#    Enclose expansion in an array to handle cases where the pattern contains
#    spaces or other special characters.
expanded_files=( $pattern )

# 4) Check if any files matched the pattern
#    If the first expanded token matches the literal pattern and files do not exist,
#    assume no valid files were found.
if [ "${#expanded_files[@]}" -eq 1 ] && [ "${expanded_files[0]}" == "$pattern" ] && [ ! -e "$pattern" ]; then
  echo "No files found matching pattern: $pattern"
  exit 0  # Not necessarily an error; just no files matched
fi

# 5) Iterate over all matched files
for file in "${expanded_files[@]}"; do

  # a) Check if this is a regular file; skip otherwise
  if [ -f "$file" ]; then

    # b) Count occurrences of the search string using grep
    #    -F ensures the search_string is treated literally.
    #    -o prints every match on a new line so that wc -l can accurately
    #       count how many matches occur.
    #    Redirect grep errors (e.g., permission issues) to /dev/null to avoid noise.
    count="$(grep -F -o -- "$search_string" "$file" 2>/dev/null | wc -l || true)"

    # c) If there was at least one occurrence, print file path and count
    if [ "$count" -gt 0 ]; then
      echo "$file: $count"
    fi
  fi
done

# End of script