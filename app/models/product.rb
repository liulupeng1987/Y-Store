class Product < ApplicationRecord
 mount_uploader :image, ImageUploader
 has_many :reviews
 # 新增/修改栏位限制与提示 #
  validates :name, presence: { message: "请输入课程名称" }
  validates :description, presence: { message: "请输入课程简介" }
  validates :price, presence: { message: "请输入课程价格" }
  validates :price, numericality: { greater_than: 0, message: "请输入课程价格，必須大于0" }
  validates :quantity, presence: { message: "请入课程席位数" }, numericality: { greater_than_or_equal: 0 }
  validates :category_id, presence: { message: "请选择课程分类" }

# 分类关联 #
  belongs_to :category

# 排序功能 #
   include RankedModel
   ranks :row_order
# 点赞功能 #
   acts_as_votable

# 收藏功能 #
   has_many :favorites
   has_many :favorite_products, through: :favorites, source: :product

end
