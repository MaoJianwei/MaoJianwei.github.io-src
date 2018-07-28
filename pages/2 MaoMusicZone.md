---
layout: default
date: 软件发布站 - 主站
title: 音乐发布
permalink: /music/
icon: glyphicon-play

noteTitle: 最新版本：1.3&#10;发布日期：2015.11.08
faxTitle: 最新版本：1.0&#10;发布日期：2015.06.06
fileTransFerTitle: 最新版本：1.0&#10;发布日期：2015.03.21
sleepReminderTitle: 最新版本：1.0&#10;发布日期：2015.07.04
mapTitle: 最新版本：1.0&#10;发布日期：2015.05.02
---

<div id="index" class="row">
  <div class="col-sm-9">

    <div class="post-area">
      <!-- small button -->
     <!--  <p class="pull-right visible-xs">
       <button>toggle</button>
     </p> -->
      <div class="post-list-header">
        Vocal
      </div>

      <div class="post-list-body">  
        <div class="all-posts" post-cate="All">
          {% for vocalPage in site.music reversed %}
              {% if vocalPage.vocalName %}
                <a class="post-list-item" href="{{ vocalPage.url | prepend: site.baseurl }}">
                  <h2>
                  {{ vocalPage.vocalName }}
                  </h2>
                  <span class="">{{ vocalPage.date | date: "%b %-d, %Y" }}</span>
                  <!-- {{ vocalPage.date | date: "%b %-d, %Y" }} -->
                </a>
              {% endif %}
          {% endfor %}
        </div>
      </div>
    </div>

    <div class="post-area" style="margin-top: 20px;">
      <div class="post-list-header">
        Keyboard
      </div>

      <div class="post-list-body">
        <div class="all-posts" post-cate="All">
          {% for kbPage in site.music reversed %}
              {% if kbPage.keyboardName %}
                <a class="post-list-item" href="{{ kbPage.url | prepend: site.baseurl }}">
                  <h2>
                  {{ kbPage.keyboardName }}
                  </h2>
                  <span class="">{{ kbPage.date | date: "%b %-d, %Y" }}</span>
                  <!-- {{ kbPage.date | date: "%b %-d, %Y" }} -->
                </a>
              {% endif %}
          {% endfor %}
        </div>
      </div>
    </div>

  </div>


  <div class="col-sm-3">

    <div class="shadow-corner-curl hidden-xs">

      <div class="categories-list-header" style=" text-align:center;">
        <a href="{{ site.myGithubLink }}/"><img alt="" class="avatar" height="230" src="{{ site.myPhoto }}" width="230" /></a>

        <h2 class="MyName">
          {{ site.myName }}
        </h2>

          <a class="University" href="http://www.bupt.edu.cn/">{{ site.chinaName }} - {{ site.BUPTname }}</a>
          <a class="email" href="mailto:{{ site.email }}">{{ site.email }}</a>
      </div>
      
      <div class="categories-list-header" style="padding-left: 13px;padding-right: 13px;padding-top: 9px;padding-bottom: 9px;">
        <div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_evernotecn" data-cmd="evernotecn" title="分享到印象笔记"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_fbook" data-cmd="fbook" title="分享到Facebook"></a><a href="#" class="bds_linkedin" data-cmd="linkedin" title="分享到linkedin"></a><a href="#" class="bds_twi" data-cmd="twi" title="分享到Twitter"></a><a href="#" class="bds_copy" data-cmd="copy" title="分享到复制网址"></a></div>
        <script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":["mshare","bdysc","renren","tqq","bdxc","kaixin001","tqf","tieba","douban","bdhome","thx","ibaidu","meilishuo","mogujie","diandian","huaban","duitang","hx","fx","youdao","sdo","qingbiji","people","xinhua","mail","evernotecn","isohu","yaolan","wealink","ty","iguba","h163","copy","print"],"bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
      </div>

<!--       <div class="categories-list-header">
        Categories
      </div>
      
      <a href="javascript:;" class="categories-list-item" cate="All">
        All<span class="my-badge"> {{site.posts | size}}</span>
      </a>
      {% for category in site.categories %}
        <a href="javascript:;" class="categories-list-item" cate="{{ category | first }}">
          {{ category | first }} <span class="my-badge">{{ category | last | size }}</span>
        </a>
      {% endfor %} -->
      
      <div class="categories-list-header">
        最近更新时间：<br />{{ site.time }}
      </div>
    </div>
  </div>
</div>
