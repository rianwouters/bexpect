source $BATS_TEST_DIRNAME/../lib/expectations

function count {
  # when grep -c returns 0, it will fail which makes bats fail the test
  echo "$[$(printf "$1\n$2"|grep -c "^$2")-1]"
}

function passed {
  echo "$(count "$output" "ok")"
}

function failed {
  echo "$(count "$output" "not ok")"
}

@test "all positive test pass" {
  run bats -t "$BATS_TEST_DIRNAME/positive-tests"
  tests=$(bats -c "$BATS_TEST_DIRNAME/positive-tests")

  expect $(failed) to equal 0
  expect $(passed) to equal "$tests"
}

@test "all negative tests fail" {
  run bats -t "$BATS_TEST_DIRNAME/negative-tests"
  tests=$(bats -c "$BATS_TEST_DIRNAME/negative-tests")

  expect $(failed) to equal "$tests"
  expect $(passed) to equal 0
}
