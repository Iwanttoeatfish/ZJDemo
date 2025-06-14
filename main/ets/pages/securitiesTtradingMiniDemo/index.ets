import { BuyOrSell } from './enum/BuyOrSell'
import emitter from '@ohos.events.emitter'
import { OrderItem } from './model/Order'
import { NavTitle } from '../NavTittle'
import { NormalCard } from '../NormalCard'

@Entry
@Component
struct SecuritiesTradingPage {
  @State message: string = 'Hello World'
  @State buyStatus: BuyOrSell = BuyOrSell.Buy
  @State unitPrice: number = 2.86
  @State count: number = 1000
  @State total: number = 0
  @State orderList: OrderItem[] = [new OrderItem(BuyOrSell.Buy, 0.00167, 10)]

  build() {
    Row() {
      Column() {
        NavTitle({
          pageName: '证劵交易中心'
        })

        Column({ space: 10 }) {
          warmPrompt('投资有风险，入市需谨慎。', Color.Black, Color.Yellow)


          NormalCard({
            marginData: { left: 14.5, right: 14.5, top: 20, bottom: 25 }
          }) {
            Column() {
              //控制板中心
              Column({ space: 10 }) {
                Row({ space: 25 }) {
                  Text('证券指数A001')
                  Text('-2.10%')
                    .fontColor(Color.Red)
                    .backgroundColor('#fff8cece')

                  Text(`实价：${this.unitPrice.toString()}`)
                    .fontColor(this.buyStatus == BuyOrSell.Buy ? Color.Green : Color.Red)

                }
                .justifyContent(FlexAlign.Center)
                .width('100%')

                Row() {
                  Button('买入', { stateEffect: false })
                    .RadiusButton(this.buyStatus == BuyOrSell.Buy ? Color.White : Color.Black, this.buyStatus == BuyOrSell.Buy ? Color.Green : $r('app.color.other_login_text_color'))
                      //.borderRadius(10)
                    .width('50%')
                    .onClick(() => {
                      this.buyStatus = BuyOrSell.Buy
                    })

                  Button('卖出', { stateEffect: false })
                    .RadiusButton(this.buyStatus == BuyOrSell.Sell ? Color.White : Color.Black, this.buyStatus == BuyOrSell.Sell ? Color.Red : $r('app.color.other_login_text_color'))
                    .borderRadius({ topRight: 10, bottomRight: 10 })
                    .width('50%')
                    .onClick(() => {
                      this.buyStatus = BuyOrSell.Sell


                    })
                }
                .width('100%')


                warmPrompt('市价委托', Color.Black, $r('app.color.other_login_text_color'))

                Row({ space: 5 }) {
                  TextInput({ placeholder: '数量/A00001', text: this.count > 0 ? this.count.toFixed(0) : '0' })
                    .borderRadius(0)
                    .type(InputType.Number)
                    .layoutWeight(1)
                    .onChange((value) => {
                      this.count = parseInt(value)
                    })
                  Blank()
                  Text('数量')

                }


                Button(this.buyStatus == BuyOrSell.Buy ? '买入' : '卖出')
                  .RadiusButton(Color.White, this.buyStatus == BuyOrSell.Buy ? Color.Green : Color.Red)
                  .borderRadius(10)
                  .width('100%')
                  .enabled(this.count > 0 ? true : false)
                  .onClick(() => {
                    //直接买入
                    this.orderList.push(new OrderItem(this.buyStatus, this.unitPrice, this.count))

                  })
              }

              //成交记录中心
              Column({ space: 15 }) {
                Text('成交记录')
                  .titleText()
                  .margin({ top: 10 })

                List({ space: 10 }) {
                  ForEach(this.orderList, (item: OrderItem) => {
                    ListItem() {
                      Column({ space: 10 }) {
                        Row({ space: 10 }) {
                          Text(item.buyStatus === BuyOrSell.Buy ? '买入' : '卖出')
                            .fontColor(item.buyStatus == BuyOrSell.Buy ? Color.Green : Color.Red)
                            .fontSize(20)

                          Text('证券指数A001')
                            .fontSize(20)

                          Blank()
                          Text('已成交 >')
                            .fontColor('#ffd4c4c4')
                            .fontSize(12)
                        }
                        .width('100%')

                        Row() {
                          Text(`时间：${item.datetime} `)
                          Blank()
                          Text(`单价：${item.unitPrice}`)
                        }
                        .width('100%')

                        Row() {
                          Text(`数量：${item.count.toFixed(0)}`)
                          Blank()
                          Text(`总金额：${item.total} `)


                        }
                        .width('100%')

                        // Text(item.count.toFixed(0))
                        Divider()
                      }
                    }
                  })
                }
                .layoutWeight(1)

              }
              .height(330)

            }
          }

        }

      }
      .width('100%')
    }
    .alignItems(VerticalAlign.Top)
    .height('100%')
    .backgroundColor($r('app.color.background_color'))
  }
}


@Extend(Text) function titleText() {
  .fontSize(25)
  .fontWeight(FontWeight.Bold)
}


/*@Builder function RadiusButton(textContent: string, textColor: Color, bgcolr: Color, widthPercent:string) {
  Button(textContent)
    .type(ButtonType.Normal)
    .fontColor(textColor)
    .backgroundColor(bgcolr)
    .borderRadius({ topLeft: 10, bottomLeft: 10 })
    .width(widthPercent)
}*/

@Extend(Button) function RadiusButton(textColor: Color, bgcolr: ResourceColor) {
  .type(ButtonType.Normal)
  .fontColor(textColor)
  .backgroundColor(bgcolr)

}


//提示横幅
@Builder function warmPrompt(textContent: string, textColor: Color, bgcolr: ResourceColor) {
  Row({ space: 6 }) {
    Image($r('app.media.Icon_ReceiptLong'))
      .height(15)
    Text(textContent)
      .fontColor(textColor)

  }
  .padding(5)
  .width('100%')
  .backgroundColor(bgcolr)
}


