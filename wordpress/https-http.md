WordPress 官方默认 Docker 是基于 Apache 来做的，但为了自动加上 SSL，我用了一个 Nginx 容器来做反向代理。于是问题出现了：用 HTTPS 访问 Nginx，生成出来的网页里面所有生成的 URL 都是 HTTP，而不是 HTTPS。



解决办法：在 wp-config.php 里面加上这样几句话：

```
if((!empty( $_SERVER['HTTP_X_FORWARDED_HOST'])) || (!empty( $_SERVER['HTTP_X_FORWARDED_FOR'])) ) { 
    $_SERVER['HTTP_HOST'] = $_SERVER['HTTP_X_FORWARDED_HOST']; 
    $_SERVER['HTTPS'] = 'on'; 
}
```