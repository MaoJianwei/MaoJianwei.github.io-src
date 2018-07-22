---
layout: music

vocalName: test-vocal-vocal
date: 2018-07-22 04:33:00 +0800

comments: true
categories: SDN ONOS P4
excerpt: 毛：只需修改元数据部分，正文部分是模板


accompaniment: 青岛雷达
recordTime: 2018-88-88
recordPlace: 北邮绿茵操场

musicCover: /resources/picture/music/test.jpg
flacLink: /resources/Music/vocal/girl_me.flac
mp3Link: /resources/Music/vocal/tear.mp3
---

<table style="border-top: 0px solid #777; border-bottom: 0px solid #777; width: 100%;">
	<td style="padding: 0px; width: 38.2%; text-align: center;">
		<img src="{{ page.musicCover }}" title="{{ page.vocalName }}" style="width: auto;">
	</td>
	<td style="vertical-align: top; width:  61.8%; padding-right: 0px;">
		<table style="border-top: 0px solid #777; border-bottom: 0px solid #777;">
			<tr style="vertical-align: bottom;">
				<blockquote>
					<p><strong>伴奏曲：　{{ page.accompaniment }}</strong></p>

					<p><strong>录制时间：{{ page.recordTime }}</strong></p>

					<p><strong>录制场地：{{ page.recordPlace }}</strong></p>
				</blockquote>
			</tr>
			<tr></tr>
			<td style="vertical-align: middle;">无损音质 FLAC：</td>
			<td><audio src="{{page.flacLink}}" controls="controls" loop="loop">您的浏览器不支持 H5 audio 标签。</audio></td>
			<tr></tr>
			<td style="vertical-align: middle;">兼容版本 MP3：</td>
			<td><audio src="{{page.mp3Link}}" controls="controls" loop="loop">您的浏览器不支持 H5 audio 标签。</audio></td>
		</table>
	</td>	
</table>
