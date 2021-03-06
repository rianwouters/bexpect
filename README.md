# bexpect
Bash expectation library inspired by rspec expections

## How to install
Just copy lib/expectations into the directory containing your tests

## How to use it
The library can work with many bash test frameworks but only tested with
[BATS](https://github.com/sstephenson/bats)

Just put ```source $BATS_TEST_DIRNAME/expectations``` in your test file.

## Examples
The examples below are sample BATS tests:

```
@test 'equality for integers and strings' {
   run "echo -n 'Hello'"
   expect $status to equal 0
   expect $output to equal 'Hello'
   expect $output not to equal 'World'
}

@test 'matching' {
   run "echo -n 'Hello World'"
   expect $output to equal 'Hello.*'
   expect $output not to equal 'World.*'
}

@test 'file existence' {
  touch foo
  expect 'foo' to exist
  expect 'bar' not to exist
}

@test 'empty file' {
  touch foo
  echo 'bar' > bar
  expect 'foo' to be_empty
  expect 'bar' not to be_empty
}

@test 'be_within' {
  expect 27.5 to be_within 0.5 of 27.9
}

@test 'end_with' {
  expect 'this string' to end_with "string"
  expect 'this string' not to end_with "stringy"
}

@test 'contains_exactly'  {
  ARR1=(v1 v2 v3)
  ARR2=(v3 v2 v1 v3)
  expect ARR1[@] to contain_exactly ARR2[@]
  expect ARR2[@] to contain_exactly ARR1[@]
}
```

## Custom matcher API

Add you own matchers as follows.

```
function matcher {
  # the last agument is the actual value to match
  # all other arguments can be used to match
  #
  # successfull match on and only on exit code 0
}
```

for example:
```
function be_liked {
  [[ `expr "$2" : "I like .* $1"` == ${#2} ]]
}

function foo {
  echo "I like $1 very much"
}

@test 'matcher API example' {
  expect "$(foo 'bar')" to be_liked 'very much'
}
```
