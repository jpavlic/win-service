= win_service

http://rubyforge.org/projects/win-service/

== DESCRIPTION:

A ruby gem that will allow the basic functions of getting the status, stopping and starting of a windows service from both a windows and a mac os x operating system.

== FEATURES/PROBLEMS:

== SYNOPSIS:

  $ irb
  >> require 'win/service'
  >> service = Win::Service.new('SERVICE_NAME', 'IP_OF_SERVER', 'USER_NAME', 'PASSWORD')
  >> service.status
  >> service.start
  >> service.pause
  >> service.resume
  >> service.stop

== REQUIREMENTS:

== INSTALL:

rake rspec (optional)
rake install

== DEVELOPERS:

After checking out the source, run:

  $ rake install

This task will install the gem, any missing dependencies and generate the RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2011 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
