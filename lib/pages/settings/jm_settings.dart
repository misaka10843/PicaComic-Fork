part of pica_settings;

class SetJmComicsOrderController extends StateController {
  int settingsOrder;

  SetJmComicsOrderController(this.settingsOrder);

  late String value = appdata.settings[settingsOrder];

  void set(String v) {
    value = v;
    appdata.settings[settingsOrder] = v;
    appdata.writeData();
    App.globalBack();
  }
}

class JmSettings extends StatefulWidget {
  const JmSettings(this.popUp, {Key? key}) : super(key: key);
  final bool popUp;

  @override
  State<JmSettings> createState() => _JmSettingsState();
}

class _JmSettingsState extends State<JmSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("禁漫天堂".tl),
        ),
        ListTile(
          leading: const Icon(Icons.favorite_border),
          title: Text("收藏夹中漫画排序模式".tl),
          trailing: Select(
            initialValue: int.parse(appdata.settings[42]),
            values: ["最新收藏".tl, "最新更新".tl],
            onChange: (i) {
              appdata.settings[42] = i.toString();
              appdata.updateSettings();
            },
          ),
        ),
        SelectSettingWithAppdata(
          icon: const Icon(Icons.domain),
          settingsIndex: 17,
          title: "Api Domain",
          options: const [
            "分流1",
            "分流2",
            "分流3",
            "分流4",
            "APP分流1",
            "APP分流2",
            "APP分流3",
            "APP分流4",
            "APP分流5",
            "自定义"
          ],
          onChanged: () => JmNetwork().loginFromAppdata(),
        ),
        ListTile(
          leading: const Icon(Icons.domain_rounded),
          title: Text(
              "自定义API: ${appdata.settings[56].replaceFirst("https://", "")}"),
          trailing: IconButton(
              onPressed: () => changeDomain(context),
              icon: const Icon(Icons.edit)),
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: Text("图片分流".tl),
          trailing: Select(
            initialValue: int.parse(appdata.settings[37]),
            values: const [
              "分流1",
              "分流2",
              "分流3",
              "分流4",
              "分流5",
              "分流6",
              "分流7",
              "分流8",
              "分流9",
              "分流10",
              "分流11",
              "分流12",
              "自定义",
            ],
            onChange: (i) {
              appdata.settings[37] = i.toString();
              appdata.updateSettings();
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: Text(
              "自定义图片API: ${appdata.settings[84].replaceFirst("https://", "")}"),
          trailing: IconButton(
              onPressed: () => changeImageDomain(context),
              icon: const Icon(Icons.edit)),
        ),
        ListTile(
          leading: const Icon(Icons.code),
          title: Text("官方API获取地址".tl),
          onTap: () => launchUrlString("https://jmcomicgo.me/",
              mode: LaunchMode.externalApplication),
          trailing: const Icon(Icons.arrow_right),
        ),
        ListTile(
          leading: const Icon(Icons.code),
          title: Text("第三方API/图片API获取地址".tl),
          onTap: () => launchUrlString(
              "https://github.com/search?q=repo%3Ahect0x7%2FJMComic-Crawler-Python%20DOMAIN_IMAGE_LIST%20&type=code",
              mode: LaunchMode.externalApplication),
          trailing: const Icon(Icons.arrow_right),
        ),
      ],
    );
  }

  void changeDomain(BuildContext context) {
    var controller = TextEditingController();

    void onFinished() {
      var text = controller.text;
      if (!text.contains("https://") || !text.contains("http://")) {
        text = "https://$text";
      }
      App.globalBack();
      if (!text.isURL) {
        showToast(message: "错误的自定义地址");
        if (appdata.settings[17] == "9") {
          appdata.settings[17] = "0";
          appdata.updateSettings();
          showToast(message: "错误的自定义地址，自动切回分流1");
        }
      } else {
        appdata.settings[56] = text;
        appdata.updateSettings();
        setState(() {});
        JmNetwork().loginFromAppdata();
      }
    }

    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("更改API域名"),
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                width: 400,
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("域名")),
                  controller: controller,
                  onEditingComplete: onFinished,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: onFinished, child: Text("完成".tl)),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              )
            ],
          );
        });
  }
}

  void changeImageDomain(BuildContext context) {
  var controller = TextEditingController();

  void onFinished() {
    var text = controller.text;
    if (!text.contains("https://") || !text.contains("http://")) {
      text = "https://$text";
    }
    App.globalBack();
    if (!text.isURL) {
      showToast(message: "错误的自定义地址");
      if (appdata.settings[37] == "12") {
        appdata.settings[37] = "0";
        appdata.updateSettings();
        showToast(message: "错误的自定义地址，自动切回分流1");
      }
    } else {
      appdata.settings[84] = text;
      appdata.updateSettings();
      JmNetwork().loginFromAppdata();
    }
  }

  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("更改图片API域名"),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              width: 400,
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("域名")),
                controller: controller,
                onEditingComplete: onFinished,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onFinished, child: Text("完成".tl)),
                const SizedBox(
                  width: 16,
                ),
              ],
            )
          ],
        );
      });
}


