#multiple test

/argv\./{
	s/"\(.*\)" "\(.*\)" "\(.*\)"/1 2 3/
	t
	s/"\(.*\)" "\(.*\)"/1 2/
	t	
	s/"\(.*\)"/1/
}