# AOL Statistics

Library for generating statistics for AOL Query Log.


## Requirements

To run this project, you need to have 

* Ruby (2.1 and more)
* Elasticsearch (1.1 and more)

## Installation

First, clone the repository.
```
git clone https://github.com/smolnar/aol-statistics.git
cd aol-statistics
```

Create data directory and download AOL dataset along with DBpedia Wiki titles.
```
mkdir data
cd data
mkdir aol
```
Move AOL dataset files to `data/aol` and `labels_en.ttl` to `data`.

Install gems.
```
bundle install
```

Run specs (make sure Elasticserch is running)
```
rspec spec
```

## Statistics

Import DBpedia.

```
rake dbpedia:import
```

Import AOL.
```
rake aol:import
```

Show statistics
```
rake aol:dump_statistics
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence 

### This code is free to use under the terms of the MIT license.

Copyright (c) 2013 Samuel Molnár

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

