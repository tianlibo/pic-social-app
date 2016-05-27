::CarrierWave.configure do |config|
  config.storage             = :qiniu
  # Config setting ins located in config.yml
  config.qiniu_access_key    = CONFIG['qiniu']['access_key']
  config.qiniu_secret_key    = CONFIG['qiniu']['secret_key']
  config.qiniu_bucket        = CONFIG['qiniu']['bucket']
  config.qiniu_bucket_domain = CONFIG['qiniu']['bucket_domain']
  # config.qiniu_bucket_private= true #default is false
  # block size什么意思？
  config.qiniu_block_size    = 4*1024*1024
  # config.qiniu_protocol      = "http"

  
  # config.qiniu_can_overwrite = true

  # config.qiniu_up_host       = 'http://up.qiniug.com' #七牛上传海外服务器,国内使用可以不要这行配置
end