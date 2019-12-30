///一。单子 Widget 布局：Container、Padding 与 Center
///1.Container:
/// a:Flutter 的 Container 仅能包含一个子 Widget
/// b:对于多个子 Widget 的布局场景，我们通常会这样处理：
/// 先用一个根 Widget 去包装这些子 Widget，
/// 然后把这个根 Widget 放到 Container 中，
/// 再由 Container 设置它的对齐 alignment、边距 padding 等基础属性和样式属性。
///
/// 2.Padding
/// 只需要将子 Widget 设定间距，则可以使用另一个单子容器控件 Padding 进行内容填充；
/// 在需要设置内容间距时，我们可以通过 EdgeInsets 的不同构造函数，
/// 分别制定四个方向的不同补白方式，如均使用同样数值留白、只设置左留白或对称方向留白等
///
/// 3.Center
/// Center 会将其子 Widget 居中排列;
/// 为了实现居中布局，Center 所占据的空间一定要比其子 Widget 要大才行，这也是显而易见的：
/// 如果 Center 和其子 Widget 一样大，自然就不需要居中，也没空间居中了。
/// 因此 Center 通常会结合 Container 一起使用。