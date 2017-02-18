module ConditionsHelper

   def radar_params
      return {
              labels: ["a.仕事の忙しさ", "b.プレッシャー",
                       "c.周囲の支え", "d.働く環境",
                       "e.職場への適応", "f.仕事への意欲",
                       "g.成果への挑戦", "h.成長実感",
                       "i.自己研鑽", "j.将来展望"],
              datasets: [
                {
                    label: "今回の結果",
                    background_color: 'rgba(192, 230, 242, 0.2)',
                    border_color: 'rgba(91, 192, 222, 0.6)',
                    border_width: 1,
                    point_background_color: 'rgba(91, 192, 222, 0.6)',
                    point_border_color: 'rgba(255, 255, 255, 1)',
                    point_hover_background_color: 'rgba(91, 192, 222, 1)',
                    point_hover_border_color: 'rgba(91, 192, 222, 1)',
                    data: [9, 6, 11, 12, 12, 13, 12, 15, 17, 7]
                },
                {
                    label: "前回の結果",
                    background_color: 'rgba(241, 194, 192, 0.2)',
                    border_color: 'rgba(217, 83, 79, 0.6)',
                    border_width: 1,
                    point_background_color: 'rgba(217, 83, 79, 1)',
                    point_border_color: 'rgba(255, 255, 255, 1)',
                    point_hover_background_color: 'rgba(217, 83, 79, 1)',
                    point_hover_border_color: 'rgba(217, 83, 79, 1)',
                    data: [12, 15, 17, 7, 9, 6, 11, 12, 12, 13]
                }
              ]
            }
   end

   def radar_option
      return {
               tooltips: { enabled: false },
               scale: {
                  pointLabels: {
                        fontSize: 9,
                        fontFamily: "'メイリオ', 'Meiryo', 'ヒラギノ角ゴ Pro W3',
                        'Hiragino Kaku Gothic Pro', 'ＭＳ Ｐゴシック','MS PGothic'"
                      },
                  ticks: {
                     display: false,
                     min: 0,
                     max: 20,
                     stepSize: 4
               }
            }
         }
   end
end
