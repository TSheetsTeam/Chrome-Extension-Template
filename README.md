# Hello, welcome to the Un-Incognito project.

Here you will find Abhishek Modi, Paul Rachwalski and Stephen Sullivan's final CS 460 project, an exploration into how websites detect incognito mode (private browsing, vegas mode, etc.) in modern browsers, and how this can be circumvented.

### Organization

In this repo, you will find an unpacked chrome extension , a mac app, and a report.

**Chrome Extension**
Designed to defeat a small subset of the incognito mode detection schemes, this Chrome extension can be loaded into chrome and then enabled in incognito mode (regard the source to ensure we don't do anything nefarious) to defeat the file system request verification, and the media sesison verification. The test pages in `Un-incognito-tests` show off some of this functionality, i.e. without the extension running, in incognito mode, the pages will show indications that you're in incognito mode, but they will not appear if in incognito mode with the extension running.

**Mac App**
This native mac application implements a special browser that more generally defeats any cache, local storage and cookie based incognito detection schemes by totally clearing any stateful information stored on the client upon navigation to each new domain. This is important because it a) allows you to use sites that require session information, i.e. logging into a site while b) preventing tracking information from being propagated to other sites. This app, for instance allows you to log into HBO Now and stream video content while also preventing your viewing history from appearing in ads on other sites.

**Report**
Our writeup details common detection schemes, common detection scheme countermeasures, and our attempts to directly defeat the detection schemes in HBO Now and Netflix with the Chrome extension.

<hr>
*Abhishek Modi - Paul Rachwalski - Stephen Sullivan*