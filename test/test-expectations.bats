source $BATS_TEST_DIRNAME/../lib/expectations


@test "all positive test pass" {
  run "bats" -t "$BATS_TEST_DIRNAME/positive-tests"
  tests=$(bats -c "$BATS_TEST_DIRNAME/positive-tests")

  # when grep -c returns 0, it will fail which makes bats fail the test
  failed=$[$(printf "$output\nnot ok"|grep -c "^not ok")-1]
  expect "$failed" to equal 0

  passed=$[$(printf "$output\nok\n"|grep -c "^ok")-1]
  expect "$passed" to equal "$tests"
}

@test "all negative tests fail" {
  run bats -t "$BATS_TEST_DIRNAME/negative-tests"
  tests=$(bats -c "$BATS_TEST_DIRNAME/negative-tests")

  failed=$[$(printf "$output\nnot ok"|grep -c "^not ok")-1]
  expect "$failed" to equal "$tests"

  passed=$[$(printf "$output\nok\n"|grep -c "^ok")-1]
  expect "$passed" to equal 0
}
