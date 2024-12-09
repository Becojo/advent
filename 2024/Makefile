today: day ?= $(shell date '+%-d')
ext ?= rb
today:
	cp -n _.$(ext) $(day).$(ext) || touch $(day).$(ext)
	touch $(day)
	touch $(day)-test
