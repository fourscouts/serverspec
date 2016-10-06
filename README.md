# serverspec
dockerised version of serverspec

Allows you to run serverspec docker tests on your Dockerfile.
It expects the following structure:

```
$ tree -L 1
.
├── Dockerfile
└── tests

$ tree tests
tests
├── Rakefile
└── spec
    ├── container_spec.rb
    ├── image_spec.rb
    └── spec_helper.rb
```

The command for running the tests is:

```
docker run -it -v "/var/run/docker.sock:/var/run/docker.sock" -v "$(PWD):/projectfiles" fourstacks/serverspec
```


