# == GIT PULL
# Pull a repo from GIT.
# This resource prevents 'overrides option' (remove
# repository and clone again) on option of module 
# vcsrepo::ensure::latest
#
# == ['ssh_identity']
# PUPPET relative path of SSH PRIVATE KEY *FILE*.
# Ex. 'profiles/ssh_keys/git-id_rsa'
#
define profiles::vcs::git_pull (
  $ssh_identity = undef,
  $ssh_port     = '22',
  $keys_dir     = '/etc/git/keys',
  $key_name     = 'producao.cgi',
  $sh_git_ssh   = 'profiles/git/ssh_git.sh.erb',
  $sh_git_run   = 'profiles/git/ssh_git.sh.run.erb',
) {
  $git_repo_dir = $name
  validate_string($identity, $git_repo_dir)
  $path_sh_git_ssh  = "${keys_dir}/${key_name}-ssh_git.sh"
  $path_sh_git_run = "${keys_dir}/${key_name}-ssh_git.sh.run"
  $identity = "${keys_dir}/${key_name}-id_rsa"
  
  file { $identity :
    path   => $identity,
    source => "puppet:///modules/${ssh_identity}",
    mode   => '0600',
    owner  => 'root',
    group  => 'root',
  } -> file { $path_sh_git_ssh :
    path    => $path_sh_git_ssh,
    content => template($sh_git_ssh),
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
  } -> file { $path_sh_git_run :
    path    => $path_sh_git_run,
    content => template($sh_git_run),
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
  }
  exec {'git_pull':
    cwd     => $git_repo_dir,
    path    => $::path,
    command => "${path_sh_git_run} git pull",
    onlyif  => "test -d ${git_repo_dir}",
    require => File[$path_sh_git_run],
  } 
  
  $message = "# GIT PULL was done. Take a look at log file [/var/log/git/pull.log]"
  notice($message)

