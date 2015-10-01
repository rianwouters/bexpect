# bexpect
Bash expectation library inspired by rspec expections

## How to install
Just copy lib/expectations into the directory containing your tests

## How to use it
The library can work with many bash test frameworks but only tested with
[BATS](https://github.com/sstephenson/bats)

Just put ```source BATS_TEST_DIRNAME/expectations``` in your test file.

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
   expect $output to equal 'Hello*'
   expect $output not to equal 'World*'
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
```
