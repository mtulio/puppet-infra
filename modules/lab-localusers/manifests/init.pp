class localusers {
	user { 'admin':
		ensure		=> present,
		shell		=> '/bin/bash',
		name		=> '/home/admin',
		gid		=> 'wheel',
		managehome 	=> true,
		password	=> '$6$PwqLo2r.YvDpNFnO$VaxS8MXNZCPKTscTEVy2uH.BfrKkcAUOA91XhmFEBq8Nqd6ghAfcnZbwL44gHPf.yT6YJtkthWZel9DNrYkbg/',
	}
	user { 'user1':
		ensure		=> present,
		shell		=> '/bin/bash',
		name		=> '/home/user1',
		gid		=> ['wheel', 'finance'],
		managehome 	=> true,
		password	=> '$6$PwqLo2r.YvDpNFnO$VaxS8MXNZCPKTscTEVy2uH.BfrKkcAUOA91XhmFEBq8Nqd6ghAfcnZbwL44gHPf.yT6YJtkthWZel9DNrYkbg/',
}
