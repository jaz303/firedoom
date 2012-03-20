# Firedoom - An Entity System Generator

&copy; 2012 Jason Frame [ [jason@onehackoranother.com](mailto:jason@onehackoranother.com) / [@jaz303](http://twitter.com/jaz303) ]

## Overview

Firedoom is a Ruby DSL for describing entity systems, and (ultimately) a collection of backend
code generators for various target languages. The initial aim is to target Java and C++.

## Try it out

Very alpha.

Ruby 1.9.x is required, along with the `active_support` gem. Now run:

    $ ruby test.rb
    
You've now generated your first entity system, in Java (it's hiding in the `src` dir).
Dive into `test.rb` to see what's going on.

## TODO

  * Java backend - generate class
  * Java backend - generate system classes
  * Engine - implement events
  * Java backend - generate events
  * much, much more...
