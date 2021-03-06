.PHONY: build lint test-unit test-functional test

build:
	docker build -t remind101/stacker .

lint:
	flake8 --require-code --min-version=2.7 --ignore FI50,FI51,FI53,FI14,E402,W503,W504,W605 --exclude stacker/tests/ stacker
	flake8 --require-code --min-version=2.7 --ignore FI50,FI51,FI53,FI14,E402,N802,W605 stacker/tests # ignore setUp naming

test-unit: clean
	AWS_ACCESS_KEY_ID=x AWS_SECRET_ACCESS_KEY=x AWS_DEFAULT_REGION=us-east-1 python setup.py nosetests

test-unit3: clean
	AWS_ACCESS_KEY_ID=x AWS_SECRET_ACCESS_KEY=x AWS_DEFAULT_REGION=us-east-1 python3 setup.py nosetests

clean:
	rm -rf .egg stacker.egg-info

test-functional:
	cd tests && bats test_suite

# General testing target for most development.
test: lint test-unit test-unit3

apidocs:
	sphinx-apidoc --force -o docs/api stacker
