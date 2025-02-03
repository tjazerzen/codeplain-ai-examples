# Initialize variables
VERBOSE=0

# Parse command line arguments
for arg in "$@"; do
  case $arg in
    -v|--verbose)
      VERBOSE=1
      ;;
  esac
done

if [ "${VERBOSE:-}" -eq 1 ] 2>/dev/null; then
    printf "Running the task manager example in verbose mode.\n"
fi

# Check if PLAIN2CODE_RENDERER variable is set
if [ -z "${PLAIN2CODE_RENDERER_DIR:-}" ]; then
    echo "Error: PLAIN2CODE_RENDERER_DIR variable is not set. Please set the PLAIN2CODE_RENDERER_DIR variable to the directory containing the plain2code.py script."
    exit 1
fi

# Removing all the end-to-end tests before rendering the thebackend servic

# python3 $PLAIN2CODE_RENDERER_DIR/plain2code.py backend-service.plain --e2e-tests-script=$PLAIN2CODE_RENDERER_DIR/test_scripts/run_e2e_tests_cypress.sh --build-folder=build --e2e-tests-folder=e2e_tests ${VERBOSE:+-v}
python3 $PLAIN2CODE_RENDERER_DIR/plain2code.py backend-service.plain --build-folder=build ${VERBOSE:+-v}

# Check if the plain2code command failed
if [ $? -ne 0 ]; then
    echo "Error: The plain2code command failed."
    exit 1
fi

printf "\nThe plain2code command ran successfully.\n"
