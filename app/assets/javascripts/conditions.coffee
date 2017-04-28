# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

   a_condition = {
                  title: "a.仕事の忙しさ",
                  summary: "やるべきことが多く、時間的負荷を感じている度合い",
                  info: "仕事をため込まずに進められている状態です",
                  danger: "仕事を抱え込み過ぎて、身動きが取れない状態かもしれません。例えば、
                           ここ一週間の間にやった仕事と、割いた時間を書き出してみましょう。
                           冷静に見ると時間をかけ過ぎていた仕事や、あなたがやらなくてもよかった
                           仕事があるかもしれません。上司や周囲の先輩に、客観的なアドバイスをもらうのも
                           よいでしょう。"
                  }
   b_condition = {
                  title: "b.プレッシャー",
                  summary: "仕事の難しさや責任の重さを感じている度合い",
                  info: "プレッシャーを感じすぎずに仕事に取り組めている状態です。",
                  danger: "責任の重さやミス・失敗を恐れ、仕事をスムーズに進められていない状態かも
                           しれません。不安なことやわからないことがあって滞っている仕事があれば、
                           具体的に洗い出してみましょう。「何が」「なぜ」滞っているのかを明確に
                           したうえで、自分一人では対応できない状況であれば、思い切って上司や
                           周囲の先輩に協力を求めてみましょう。"
                  }
   c_condition = {
                  title: "c.周囲の支え",
                  summary: "上司・同僚とのコミュニケーションがうまくいかないと感じている度合",
                  info: "上司や同僚など、周囲と円滑にコミュニケーションが取れている状態です。",
                  danger: "上司や同僚との日頃のコミュニケーションや、仕事の連携に困っている状態かも
                           しれません。周りの人たちが忙しそうだからと、遠慮していませんか。日々の報告・
                           連絡・相談を行わないことで、もっと迷惑が掛かってしまうこともあります。
                           思い切って声をかけてみることで、状況が打開する事も多いものですよ。"
                  }
   d_condition = {
                  title: "d.働く環境",
                  summary: "職場の環境や仕組み・制度に不満を感じている度合い",
                  info: "職場の環境や仕組み、制度に満足している状態です。",
                  danger: "職場環境や人事・労務関連の制度、あるいは属人的で仕組み化されていない仕事の
                           進め方に不都合を感じている状態かもしれません。あなたが不満や不便を感じている
                           ことについて、原因は何なのか、どうすれば改善するのか、職場の人たちと話しあって
                           みるのも解決策の一つです。"
                  }
   e_condition = {
                  title: "e.仕事・職場への適応",
                  summary: "仕事や職場で自分らしさを出せていないと感じる度合い",
                  info: "仕事や職場になじみ、自分らしく働けていると思えている状態です。",
                  danger: "仕事で成果がなかなかでない、職場の雰囲気になじめないなど、居心地の悪さを
                           感じている状態かもしれません、初めての環境に慣れるには、誰しも時間が
                           かかるものです。マイナス面だけでなく、できるようになったことや面白いと
                           感じたことなど、プラスの側面にも目を向けるよう意識してみましょう。"
                  }
   a_condition = {
                  title: "a.仕事の忙しさ",
                  summary: "やるべきことが多く、時間的負荷を感じている度合い",
                  info: "仕事をため込まずに進められている状態です",
                  danger: "仕事を抱え込み過ぎて、身動きが取れない状態かもしれません。例えば、
                           ここ一週間の間にやった仕事と、割いた時間を書き出してみましょう。
                           冷静に見ると時間をかけ過ぎていた仕事や、あなたがやらなくてもよかった
                           仕事があるかもしれません。上司や周囲の先輩に、客観的なアドバイスをもらうのも
                           よいでしょう。"
                  }
   f_condition = {
                  title: "f.仕事への意欲",
                  summary: "仕事に対する前向きさの度合い",
                  info: "仕事に対してやりがいを感じ、前向きに取り組めている状態です。",
                  danger: "仕事に楽しさや意義を見出せず、いまひとつ力が入らない状態かもしれません。
                           やるべきことがあるのに身が入らないときには、短時間で仕上げられる仕事から
                           着手し、やる気に助走をつけてみましょう。疲れがたまって意欲を保てないときには、
                           思い切って休む方が効果的なこともあります。"
                  }
   g_condition = {
                  title: "g.成果への挑戦",
                  summary: "高い成果やより良い状態を目指そうとしている度合い",
                  info: "高い目標にチャレンジし、現状をより良くしようと思えている状態です。",
                  danger: "目の前の仕事で手一杯だったり、未知の経験に飛び込むことに尻込みしている
                           状態かもしれません。大幅に背伸びが必要なことや、目覚ましい成果を上げること
                           だけが挑戦ではありません。日々の仕事の中であと一歩頑張ればできることを
                           積み重ね、前進していきましょう。"
                  }
   h_condition = {
                  title: "h.成長実感",
                  summary: "仕事や同僚との関わりの中で成長を感じている度合い",
                  info: "仕事を通じて成長を感じたり、周囲からプラスの刺激を受けたりしている状態です。",
                  danger: "日々の死後tの中で、新たなことを学んでいるという手応えを得にくい状態かも
                           しれません。成長とは自分では気づきにくいものです。あなたの仕事ぶりをよく知る
                           先輩や上司に、少し前と比べて変わった点を言ってもらったり、どこを改善すると
                           良くなるかをたずねてみるのも有効です。"
                  }
   i_condition = {
                  title: "i.自己研鑽",
                  summary: "仕事のために自身を高める努力をしている度合い",
                  info: "自分を高めるための時間を作り、積極的にインプットができている状態です。",
                  danger: "目の前の仕事をこなすばかりで、新たなインプットを行えていないと感じる状態かも
                           しれません。何を学ぶべきか明確になっていない場合は、まず一つ置いてみましょう。
                           学ぶ方法や時間の確保の仕方については周囲の人たちに尋ね、やってみたいと思った
                           ことから取り組んでいきましょう。"
                  }
   j_condition = {
                  title: "j.将来展望",
                  summary: "自分の将来像をイメージできている度合い",
                  info: "仕事を通してどのように成長していけそうかイメージできている状態です。",
                  danger: "今後目指す姿や、そこに至るステップが見えず不安を抱えている状態かもしれません。
                           キャリアの問題は、社会人としてずっと付き合っていくテーマです。一人で悶々と
                           しすぎず、あなたの先を行く社内外の先輩たちと会話しながらイメージをつけていくと
                           よいでしょう。"
                  }

   changeDescription = (condition) ->
      $('#description-title').html(condition.title)
      $('#description-summary').html(condition.summary)
      $('#description-info').html(condition.info)
      $('#description-danger').html(condition.danger)


   $('#words-list > ul:nth-child(2) > li:nth-child(2)').click ->
         changeDescription(a_condition)
   $('#words-list > ul:nth-child(2) > li:nth-child(3)').click ->
         changeDescription(b_condition)
   $('#words-list > ul:nth-child(2) > li:nth-child(4)').click ->
         changeDescription(c_condition)
   $('#words-list > ul:nth-child(2) > li:nth-child(5)').click ->
         changeDescription(d_condition)
   $('#words-list > ul:nth-child(2) > li:nth-child(6)').click ->
         changeDescription(e_condition)
   $('#words-list > ul:nth-child(3) > li:nth-child(2)').click ->
         changeDescription(f_condition)
   $('#words-list > ul:nth-child(3) > li:nth-child(3)').click ->
         changeDescription(g_condition)
   $('#words-list > ul:nth-child(3) > li:nth-child(4)').click ->
         changeDescription(h_condition)
   $('#words-list > ul:nth-child(3) > li:nth-child(5)').click ->
         changeDescription(i_condition)
   $('#words-list > ul:nth-child(3) > li:nth-child(6)').click ->
         changeDescription(j_condition)


# generate a line chart
