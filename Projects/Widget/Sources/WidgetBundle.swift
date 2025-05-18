import WidgetKit
import SwiftUI

@main
struct MyWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        MyExampleWidget()   // ← 실제로 만든 위젯 구조체 이름
    }
}
