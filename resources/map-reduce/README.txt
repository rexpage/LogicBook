This directory contains the following files:

	map-reduce.lisp -- main implementation of map/reduce framework

	wordcount.lisp -- basic example using mapreduce

	hightemp.lisp -- another basic example using mapreduce

	urls.lisp -- variation on Google's classic example of using mapreduce

	cluster.lisp -- more complex example showing iterative
	mapreduce.  Demonstrates k-clustering algorithm.

	gen-cluster-data.lisp -- LISP (*not* ACL2) program that
	generates random data to test the clustering algorithm

To write a new map/reduce program you need to do the following:

1) Use wordcount.lisp as a model

2) Start with 

	(include-book "map-reduce") 

   to load the map/reduce framework.

3) Think about the hashes you will use for map/reduce.  There are
	three parts:

        a) What is the original input to mapreduce.  In wordcount,
        this consists of a hash with keys equal to the word, and
        values equal to the partial count (initiallly 1).

	b) What is the output of the map function (which determines
	the input to the reduce function).  For wordcount, this is the
	same as the input, but it can something else.

	c) What is the output of the reduce function (which determines
	the output of the map/reduce operation).  For wordcount, this
	is the same as the input, except the count is now a final
	count, because it is to the total of all the partial counts.

4) Implement the map function.  You can give it any name, but it
	should take two arguments, a key and a value from your input
	list.  The output should be a list of (key value) pairs, which
	will be collected and passed on to your reduce function.

5) Implement the reduce function.  Again, you can use any name you
	like, but the input consits of a key and a list of values,
	where the key and each of the values in the list is output
	from a map function.

6) Define the main mapreduce function using

	(defmapreduce wordcount wc-map wc-reduce)

     Here, "wordcount" is the name of the mapreduce function you want
     to define, and "wc-map" and "wc-reduce" are the names of the
     map and functions you defined in steps 4 and 5.

7) Run your function.  The input to the mapreduce function (e.g,
     "wordcount")  should be a list of key/values pairs, where each
     key and value are in the format expected by your map function.
     For example,

	(wordcount '( (four 1) (score 1) (and 1) ... ) )
