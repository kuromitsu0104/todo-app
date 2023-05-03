require "rails_helper"

RSpec.describe Layouts::BreadcrumbComponent, type: :component do
  describe "#render" do
    context "パラメータが正常な場合" do
      context "「任意の正常な値」の場合" do
        it "表示に成功すること" do
          render_preview(:default)

          expect(page).to be_truthy
        end

        it "パンくずの表示内容が正しいこと" do
          render_preview(:default)

          expect(page).to have_selector("a.items-center", text: "Hoge")
          expect(page).to have_link("Hoge", href: "/")
          expect(page).to have_selector("a.items-center", text: "Fuga")
          expect(page).to have_link("Fuga", href: "/fuga")
          expect(page).to have_selector("li.font-semibold", text: "Me")
          expect(page).not_to have_link("Me", href: "/")
        end
      end

      context "「空配列」の場合" do
        it "表示に成功すること" do
          render_preview(:with_blank_array)

          expect(page).to be_truthy
        end

        it "パンくずが表示されないこと" do
          render_preview(:with_blank_array)

          expect(page).not_to have_selector("a.items-center")
          expect(page).not_to have_selector("li.font-semibold")
        end
      end
    end

    context "パラメータが異常な場合" do
      context "パラメータが「nil」の場合" do
        it "例外が発生して表示に失敗すること" do
          expect { render_preview(:with_nil_params) }.to raise_error(StandardError)
        end
      end
    end
  end
end
