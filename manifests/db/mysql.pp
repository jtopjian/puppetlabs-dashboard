class dashboard::db::mysql (
  $client_host = 'localhost',
  $db_charset  = $::dashboard::params::database_charset,
  $db_name     = $::dashboard::params::database_db,
  $db_user,
  $db_password
) {
  
  mysql::db { $db_name:
    user     => $db_user,
    password => $db_password,
    host     => $client_host,
    charset  => $db_charset,
  }

}
