class PostsModel {
  String profileImg;
  String name;
  String location;
  String postImg;
  int count = 0;
  bool isLike = false;
  PostsModel(
      {required this.profileImg,
      required this.name,
      required this.location,
      required this.postImg,
      required this.count,
      required this.isLike});
}

List<PostsModel> postsModel = [
  PostsModel(
      profileImg:
          "https://imgs.search.brave.com/wT_6lGAr-egZPhwJx62_5sFiaicaUfSx3W_Gc46Olc4/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM1/NzkzMDAzOC9waG90/by9pbmZsdWVuY2Vy/LWFwcGx5aW5nLW1h/c2NhcmEtYXQtaG9t/ZS1zdHVkaW8uanBn/P3M9NjEyeDYxMiZ3/PTAmaz0yMCZjPUd5/dE1QLWtEdGNON2M4/TTVCZXpqZ1ZOS1JP/NUdmb2RCNTdKQV9x/ckFyMnM9",
      name: "Prajakta Budyal",
      location: "Maldives",
      postImg:
          "https://imgs.search.brave.com/kawrtbnBAaNWbWe5N-zSEszPMswUTWKu0Vu-zKBaC0g/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNjIz/MzA5MzQwL3Bob3Rv/L21hbGRpdmVzLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz03/NHZQU2l1eXJqSVJm/b25adXhXZkQwU0Jm/a3lrTTNJbUZSZDlP/NGZZa0FjPQ",
      count: 0,
      isLike: false),
  PostsModel(
      profileImg:
          "https://imgs.search.brave.com/GgaSYp8sW-J7e5vl9X65K2Si9uOYsd9h783YyoAFxjA/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTQ3/MDQzNTMxOC9waG90/by92bG9nZ2VyLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz1F/LUgzRWZEaUlzTWxS/T1ZmeGRTZnM4SjUx/ZTJJWXUzNnZvbG50/elBMbW84PQ",
      name: "Siddhesh Patbage",
      location: "Brazil",
      postImg:
          "https://imgs.search.brave.com/Z3Qwu5SgNu9VIGKvuxNG6sh0P9FEP6rwypdV2hMmH-U/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9waG90/b3Muc211Z211Zy5j/b20vVHJhdmVsL0lj/ZWxhbmQvSWNlbGFu/ZC1lYm9vay9FYm9v/ay1sYXJnZS9pLXY2/UG1wUFcvMS9ML0Yy/MDglMjBsLUwuanBn",
      count: 0,
      isLike: false)
];

List specials = [
  "https://imgs.search.brave.com/QX9VSzK9-xEQFmbwmpNyKlAUde_zOj2GZc6xLOddSyk/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE1/MTQ1MzMyMTI3MzUt/NWRmMjdkOTcwZGIw/P2ZtPWpwZyZxPTYw/Jnc9MzAwMCZpeGxp/Yj1yYi00LjAuMyZp/eGlkPU0zd3hNakEz/ZkRCOE1IeHpaV0Z5/WTJoOE1UTjhmRzFo/Y25Ob2JXVnNiRzk4/Wlc1OE1IeDhNSHg4/ZkRBPQ.jpeg",
  "https://imgs.search.brave.com/kawrtbnBAaNWbWe5N-zSEszPMswUTWKu0Vu-zKBaC0g/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNjIz/MzA5MzQwL3Bob3Rv/L21hbGRpdmVzLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz03/NHZQU2l1eXJqSVJm/b25adXhXZkQwU0Jm/a3lrTTNJbUZSZDlP/NGZZa0FjPQ",
  "https://imgs.search.brave.com/Z3Qwu5SgNu9VIGKvuxNG6sh0P9FEP6rwypdV2hMmH-U/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9waG90/b3Muc211Z211Zy5j/b20vVHJhdmVsL0lj/ZWxhbmQvSWNlbGFu/ZC1lYm9vay9FYm9v/ay1sYXJnZS9pLXY2/UG1wUFcvMS9ML0Yy/MDglMjBsLUwuanBn",
];
