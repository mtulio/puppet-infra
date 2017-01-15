# == GIT SSH WRAPPER
# Creates a GIT SSH wrapper.
#
# == ['ssh_identity']
# PUPPET relative path of SSH PRIVATE KEY *FILE*.
# Ex. 'profiles/ssh_keys/git-id_rsa'
#
define profiles::vcs::git_wrapper (
  $ssh_identity = undef,
  $ssh_port     = '22',
  $keys_dir     = '/etc/git/keys',
  $key_name     = 'mykey',
  $git_wrapper  = 'profiles/git/git-wrapper.erb',
  $git_ssh      = 'profiles/git/git-wrapper-ssh.sh.erb',
) {

  $git_repo_dir = $name
  validate_string($identity, $git_repo_dir)

  $path_git_wrapper = "${keys_dir}/${key_name}_git-wrapper.sh"
  $path_git_ssh     = "${keys_dir}/${key_name}_git-wrapper-ssh.sh"
  $path_identity    = "${keys_dir}/${key_name}_key"
  
  file { $identity :
    path   => $path_identity,
    source => "puppet:///modules/${ssh_identity}",
    mode   => '0600',
    owner  => 'root',
    group  => 'root',
  } -> file { $path_git_wrapper :
    path    => $path_git_wrapper,
    content => template($git_wrapper),
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
  } -> file { $path_git_ssh :
    path    => $path_git_ssh,
    content => template($git_ssh),
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
  }
  
  notice("The GIT wrapper was created at ${path_git_ssh}. You can send git command as a argument of this wrapper.")
}
