#!/usr/bin/perl
###########################
#
# Store-ID dengan asumsi chanel berapapun 
#
###########################
$|=1;
while (<>) {
my $chan = "";
if (s/^(\d+\s+)//o) {
$chan = $1;
}
$_ =~ s/(\s+.+)//o;

if ($_ =~ m/^https?\:\/\/.*youtube.*(ptracking|stream_204|player_204|gen_204).*(video_id|docid|v)\=([^\&\s]*).*/){
        $vid = $3 ;
        @cpn = m/[&?]cpn\=([^\&\s]*)/;
                $fn = "/var/log/squid3/@cpn";
                unless (-e $fn) {
                        open FH,">".$fn ;
                        print FH "$vid\n";
                        close FH;
                } 
        print $chan, "ERR\n" ;

} elsif ($_ =~ m/^https?\:\/\/.*(youtube|google).*videoplayback.*/){
        @itag = m/[&?](itag=[0-9]*)/;
        @ids = m/[&?]id\=([^\&\s]*)/;
        @mime = m/[&?](mime\=[^\&\s]*)/;
        @cpn = m/[&?]cpn\=([^\&\s]*)/;
        @range = m/[&?](range=[^\&\s]*)/;
        if (defined($cpn[0])) {
            $fn = "/var/log/squid3/@cpn";
            if (-e $fn) {
                open FH,"<".$fn ;
                $id  = <FH>;
                chomp $id ;
                close FH ;
                  } else {
                $id = $ids[0] ;
            }
        print $chan, "OK store-id=http://googlevideo.squid.internal/id=" . $id . "&@itag@range@mime\n" ;
        } else {
        print $chan, "ERR\n" ;
        }

} elsif ($_ =~ m/^http:\/\/(videos|photos|scontent)[\-a-z0-9\.]*instagram\.com\/hphotos[\-a-z0-9]*\/([\w\d\-\_\/\.]*.(mp4|jpg))/){
        print $chan, "OK store-id=http://instagram.squid.internal/$2\n" ;
} elsif ($_ =~ m/^http:\/\/distilleryimage[\-a-z0-9\.]*instagram\.com\/(.*)/){
        print $chan, "OK store-id=http://instagram.squid.internal/$1\n" ;

} elsif ($_ =~ m/^https?:\/\/.*\.steampowered\.com\/depot\/[0-9]+\/chunk\/([^\?]*)/){
        print $chan, "OK store-id=http://steampowered.squid.internal/$1\n" ;

} elsif ($_ =~ m/^https?:\/\/.*(fbcdn|akamaihd)\.net\/.*\/(.*\.mp4)(.*)/) {
        print $chan, "OK store-id=storeurl://facebook.squid.internal/$2\n" ;

} elsif ($_ =~ m/^https?:\/\/.*(static|profile).*a\.akamaihd\.net(\/static-ak\/rsrc\.php\/v[0-9]\/(.*\.(mp4|jpg|bmp|png|flv|m4v|gif|jpeg)))/) {
        print $chan, "OK store-id=http://facebook.squid.internal/$3\n" ;
} elsif ($_ =~ m/^https?:\/\/.*(static|profile).*\.ak\.fbcdn\.net(\/static-ak\/rsrc\.php\/v[0-9]\/(.*\.(mp4|jpg|bmp|png|flv|m4v|gif|jpeg)))/) {
        print $chan, "OK store-id=http://facebook.squid.internal/$3\n" ;
} elsif ($_ =~ m/^https?:\/\/.*(static|profile).*a\.akamaihd\.net(\/rsrc\.php\/v[0-9]\/(.*))/) {
        print $chan, "OK store-id=http://facebook.squid.internal/$3\n" ;
} elsif ($_ =~ m/^https?:\/\/.*(static|profile).*\.ak\.fbcdn\.net(\/rsrc\.php\/v[0-9]\/(.*))/) {
        print $chan, "OK store-id=http://facebook.squid.internal/$3\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*(fbcdn|akamaihd)[^\/]*net\/rsrc\.php\/(.*\.(mp4|jpg|bmp|png|flv|m4v|gif|jpeg))/) {
        print $chan, "OK store-id=http://facebook.squid.internal/$2\n" ;

} elsif ($_ =~ m/^https?:\/\/[^\/]*(fbcdn|akamaihd)[^\/]*net\/safe\_image\.php\?.*(url\=.*\.(mp4|jpg|bmp|png|flv|m4v|gif|jpeg)).*/) {
        print $chan, "OK store-id=http://facebook.squid.internal/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/i[0-2].wp\.com\/graph\.facebook\.com\/(.*)/) {
        print $chan, "OK store-id=http://facebook.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/(video\.ak\.fbcdn\.net)\/(.*?)\/(.*\.mp4)\??.*$/) {
        print $chan, "OK store-id=http://facebook.squid.internal/$1/$3\n" ;
} elsif ($_ =~ m/^https?:\/\/video\.(.*)\.fbcdn\.net\/(.*?)\/([0-9_]+\.(mp4|flv|avi|mkv|m4v|mov|wmv|3gp|mpg|mpeg)?)(.*)/) {
        print $chan, "OK store-id=http://facebook.squid.internal/$3\n" ;
} elsif ($_ =~ m/^https?:\/\/(fbcdn|scontent).*(akamaihd|fbcdn)\.net\/(h|s)(profile|photos).*\/((p|s).*\.(png|gif|jpg))(\?.+)?$/){
        print $chan, "OK store-id=http://facebook.squid.internal/$5\n" ;
} elsif ($_ =~ m/^https?:\/\/(fbcdn|scontent).*(akamaihd|fbcdn)\.net\/(h|s)(profile|photos).*\/(.*\.(png|gif|jpg))(\?.+)?$/){
        print $chan, "OK store-id=http://facebook.squid.internal/$5\n" ;

} elsif ($_ =~ m/^https?:\/\/attachment\.fbsbx\.com\/.*\?(id=[0-9]*).*/) {
        print $chan, "OK store-id=http://facebook.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https:\/\/.*\.google\.com\/chrome\/win\/.+\/(.*\.exe)/){
        print $chan, "OK store-id=http://update-google.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.ytimg\.com\/(.*\.(webp|jpg|gif))/){
        print $chan, "OK store-id=http://ytimg.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*firedrive\.com\/download\/[0-9]+\/[0-9]+\/.*\?h=.*e\=.*f\=(.*)\&.*/){
        print $chan, "OK store-id=http://firedrive.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.4shared\.com\/.*\/dlink__[23]F([\w]+)_[23]F(.*)\_3Ftsid_[\w].*/){
        print $chan, "OK store-id=http://4shared.squid.internal/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.4shared\.com\/download\/([^\/]*).*/){
        print $chan, "OK store-id=http://4shared.squid.internal/$1\n" ;

} elsif ($_ =~ m/^https?:\/\/.*\.[a-z]+\.bing\.net\/(.*)\&w=.*/){
        print $chan, "OK store-id=http://bing.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.bing\.(net|com)\/.*\?id=([a-zA-Z]\.[0-9]+)&pid=.*/){
        print $chan, "OK store-id=http://bing.squid.internal/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.gstatic\.com\/images\?q=tbn\:(.*)/){
        print $chan, "OK store-id=http://gstatic.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.reverbnation\.com\/.*\/(ec_stream_song|download_song_direct|stream_song)\/([0-9]*).*/){
        print $chan, "OK store-id=http://reverbnation.squid.internal/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.dl\.sourceforge\.net\/(.*\.(exe|zip|mp3|mp4))/){
        print $chan, "OK store-id=http://sourceforge.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/fs[0-9]+\.filehippo\.com\/[^\/]*\/[^\/]*\/(.*)/){
        print $chan, "OK store-id=http://filehippo.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/download[0-9]+.mediafire\.com\/.*\/\w+\/(.*)/){
        print $chan, "OK store-id=http://mediafire.squid.internal$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*android\.clients\.google\.com\/[a-z]+\/[a-zA-Z]+\/[a-zA-Z]+\/(.*)\/([0-9]+)\?.*/){
        print $chan, "OK store-id=http://android.squid.internal/$1/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/.*(googleusercontent.com|blogspot.com)\/(.*)\/([a-z0-9]+)(-[a-z]-[a-z]-[a-z]+)?\/(.*\.(jpg|png))/){
        print $chan, "OK store-id=http://googleusercontent.squid.internal/$5\n" ;
} elsif ($_ =~ m/^https?:\/\/global-shared-files-[a-z][0-9]\.softonic\.com\/.{3}\/.{3}\/.*\/.*\=(.*\.exe)/){
        print $chan, "OK store-id=http://softonic.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*netmarble\.co\.id\/.*\/(data|ModooMarble)\/(.*)/){
        print $chan, "OK store-id=http://netmarble.squid.internal/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/(.*)\.windowsupdate\.com\/(.*)\/(.*)\/([a-z].*)/){
        print $chan, "OK store-id=http://windowsupdate.squid.internal/$4\n" ;
} elsif ($_ =~ m/^https?:\/\/.*filetrip\.net\/.*\/((.*)\.([^\/\?\&]{2,4}))\?.*$/){
        print $chan, "OK store-id=http://filetrip.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*get4mobile\.net\/.*f=([^\/\?\&]*).*$/){
        print $chan, "OK store-id=http://get4mobile.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*thestaticvube\.com\/.*\/(.*)/){
        print $chan, "OK store-id=http://thestaticvube.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/113\.6\.235\.171\/youku\/.*\/(.*\.flv)/){
        print $chan, "OK store-id=http://youku.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/\d+\.\d+\.\d+\.\d+\/drama\/(.*\.mp4)\?.*\=(\d+)/){
        print $chan, "OK store-id=http://drama.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/([a-z])[\d]{1,2}?(.gstatic\.com.*|\.wikimapia\.org.*)/){
        print $chan, "OK store-id=http://gstatic.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.[a-z][0-9]\.(tiles\.virtualearth\.net)\/(.*\&n=z)/){
        print $chan, "OK store-id=http://virtualearth.squid.internal/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/imgv2-[0-9]\.scribdassets\.com\/(.*)/){
        print $chan, "OK store-id=http://scribdassets.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/(.*?)\/(archlinux\/[a-zA-Z].*\/os\/.*)/){
        print $chan, "OK store-id=http://archlinux.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/(.*?)\/speedtest\/(.*\.(jpg|txt))\??.*$/){
        print $chan, "OK store-id=http://speedtest.squid.internal/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/i[1-9]{3}\.photobucket\.com\/(.*)/){
        print $chan, "OK store-id=http://photobucket.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/i[1-9]{4}\.photobucket\.com\/(.*)/){
        print $chan, "OK store-id=http://photobucket.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/avideos\.5min\.com\/.*\/(.*)\?.*/){
        print $chan, "OK store-id=http://avideos.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.catalog\.video\.msn\.com\/.*\/(.*\.(mp4|flv|m4v))/){
        print $chan, "OK store-id=http://msn-video.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/v\.imwx\.com\/.*\/(.*)\?.*/){
        print $chan, "OK store-id=http://imwx.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/video[0-9]\.break\.com\/.*\/(.*)\?.*/){
        print $chan, "OK store-id=http://break.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.video[0-9]\.blip\.tv\/.*\/(.*)\?.*/){
        print $chan, "OK store-id=http://blip.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/ss[0-9]\.vidivodo\.com\/vidivodo\/vidservers\/server[0-9]*\/videos\/.*\/([a-zA-Z0-9.]*)\?.*/){
        print $chan, "OK store-id=http://vidivodo.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/video\-http\.media\-imdb\.com\/([a-zA-Z0-9\@\_\-]+\.(mp4|flv|m4v))\?.*/){
        print $chan, "OK store-id=http://imdb-video.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/(vl|v)\.mccont\.com\/(.*)\/(.*\.(mp4|m4v|flv))\?.*/){
        print $chan, "OK store-id=http://mccont.squid.internal/$3\n" ;
} elsif ($_ =~ m/^https?:\/\/(vid.{0,2}|proxy.*)(\.ak|\.ec|\.akm|)\.(dmcdn\.net|dailymotion\.com)\/.*\/(frag.*\.(flv|mp4|m4v)).*/){
        print $chan, "OK store-id=http://dailymotion.squid.internal/$4\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.vimeo[^\/]*\.com.*\/([[^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg|web))\?.*/){
        print $chan, "OK store-id=http://vimeo.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/fcache\.veoh\.com\/.*\/.*(l[0-9]*\.(mp4|flv))\?.*/){
        print $chan, "OK store-id=http://veoh.squid.internal$1\n" ;
} elsif ($_ =~ m/^https?:\/\/video\.thestaticvube\.com\/.*\/(.*)/){
        print $chan, "OK store-id=http://thestaticvube.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/cdn[0-9]\.videos\.videobash\.com\/.*\/(.*\.(mp4|m4v|flv))\?.*/){
        print $chan, "OK store-id=http://videobash.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.phncdn[^\/]*\.com.*\/([[^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://phncdn.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.xvideos\.com\/.*\/([^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://xvideos.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.tube8[^\/]*\.com.*\/([^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://tube8.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.(redtube|redtubefiles)\.com\/.*\/([^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://redtube.squid.internal/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/.*\/xh.*\/([^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))/){
        print $chan, "OK store-id=http://xhcdn.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.xhcdn[^\/]*\.com.*\/([^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://xhcdn.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.nsimg[^\/]*\.net.*\/([^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://nsimg.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.youjizz\.com.*\/([^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://youjizz.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.public\.keezmovies[^\/]*\.com.*\/([^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://keezmovies.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.youporn[^\/]*\.com.*\/([^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://youporn.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.spankwire[^\/]*\.com.*\/([^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://spankwire.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.pornhub[^\/]*\.com.*\/([[^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://pornhub.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.us.playvid[^\/]*\.com.*\/([[^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://playvid.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.slutload-media[^\/]*\.com.*\/([[^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://slutload-media.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.hardsextube[^\/]*\.com.*\/([[^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://hardsextube.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*\.public\.extremetube[^\/]*\.com.*\/([[^\/]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
        print $chan, "OK store-id=http://extremetube.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/([a-z0-9.]*)(\.doubleclick\.net|\.quantserve\.com|.exoclick\.com|interclick.\com|\.googlesyndication\.com|\.auditude\.com|.visiblemeasures\.com|yieldmanager|cpxinteractive)(.*)/){
        print $chan, "OK store-id=http://ads.squid.internal/$3\n" ;
} elsif ($_ =~ m/^https?:\/\/(.*?)\/(ads)\?(.*?)/){
        print $chan, "OK store-id=http://ads.squid.internal/$3\n" ;
} elsif ($_ =~ m/^https?:\/\/[^\/]*phobos\.apple\.com\/.*\/([^\/]*\.ipa)/){
        print $chan, "OK store-id=http://apple.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/fs\w*\.fileserve\.com\/file\/(\w*)\/[\w-]*\.\/(.*)/){
        print $chan, "OK store-id=http://fileserve.squid.internal/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/s[0-9]*\.filesonic\.com\/download\/([0-9]*)\/(.*)/){
        print $chan, "OK store-id=http://filesonic.squid.internal/$2\n" ;
} elsif ($_ =~ m/^https?:\/\/download[0-9]{3}\.avast\.com\/(.*)/){
        print $chan, "OK store-id=http://avast.squid.internal/41\n" ;
} elsif ($_ =~ m/^https?:\/\/[a-zA-Z0-9]+\.[a-zA-Z0-9]+x\.[a-z]\.avast\.com\/[a-zA-Z0-9]+x\/(.*\.vpx)/){
        print $chan, "OK store-id=http://avast.squid.internal\$1\n" ;
} elsif ($_ =~ m/^https?:\/\/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/(iavs.*)/){
        print $chan, "OK store-id=http://iavs.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/.*\.starhub\.com\/[a-z]+\/[a-z]+\/[a-z]+\/(.*exe)\?[0-9]/){
        print $chan, "OK store-id=http://starhub.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/dnl-[0-9]{2}\.geo\.kaspersky\.com\/(.*)/){
        print $chan, "OK store-id=http://kaspersky.squid.internal/$1\n" ;
} elsif ($_ =~ m/^https?:\/\/([^\.]*)\.yimg\.com\/(.*)/){
        print $chan, "OK store-id=http://yimg.squid.internal/$1\n" ;
} else {
        print $chan, "ERR\n" ;
}
}