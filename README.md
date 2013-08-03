Using-prolog-from-other-languages
=================================
json_svc.pl
is a sample which shows how to setup a prolog (swi-prolog) jsonrpc service.
In this sample the service hosts a sudoku solver program, but can be replaced/extended with whatever you like (try it out with the python sample)
(the sample is inspired by this blog post: http://technogems.blogspot.dk/2011/08/easy-cross-platform-inter-process.html)

you run the service by typing:
?- [json_svc].
?- server(5000) % to run the service at port 5000


python_jsonrpc_sample.py
is a sample python script which shows how to use the jsonrpclib to communicate with prolog

just run it in the console by typing:
python python_jsonrpc_sample.py
