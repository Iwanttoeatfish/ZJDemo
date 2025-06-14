import router from '@ohos.router'

@Preview
@Component
export struct NavTitle {
  pageName?: string

  build() {
    Row() {
      Row() {
        Image($r('app.media.back_icon'))
          .width(30)
          .height(30)
        Text(this.pageName)
          .fontSize(15)
          .width('80%')
          .textAlign(TextAlign.Center)
      }
      .margin({ top: 10 })

    }
    .width('100%')
    .padding(10)
    .backgroundColor($r('app.color.start_window_background'))
    .onClick(() => {
      router.back()
    })

  }
}