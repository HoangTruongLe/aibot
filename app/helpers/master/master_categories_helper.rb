module Master::MasterCategoriesHelper
  def render_master_categories_tree(master_categories)
    html = ""
    master_categories.each do |master_category|
      html += render_sub_tree(master_category)
    end
    html
  end

  def render_sub_tree(master_category)
    html = '<li>'
    html += master_category_row(master_category)
    if master_category.childs.count > 0
      html += '<ul>'
      master_category.childs.includes(:childs).each do |child|
        html += render_sub_tree(child)
      end
      html += '</ul>'
    end
    html += '</li>'
  end

  def master_category_row(master_category)
    "<span>
        <span class='category-info'>
          #{ truncate(master_category.name, length: 20) }
        </span>
        <span style='margin-left: 20px'>
          (サブカテゴリ：#{master_category.childs.count})
        </span>
        <span style='margin-left: 20px'>
          #{format_activity(master_category.activity)}
        </span>
        <span class='category-action'>
          <button data-toggle='modal' data-target='#top_master_category'
                  onclick=\"set_parent_id('#{ master_category.id }')\"
                  class='btn btn-primary btn-submit-filter btn-blue'
                  style='width: 160px;'>
            #{ t('.create_sub_master_category') }
          </button>

          <button onclick=\"edit_master_category('#{ master_category.id.to_s }', '#{ master_category.parent_id.to_s }', '#{ master_category.name.to_s }', '#{ master_category.activity.to_s }')\"
                  class='btn btn-primary btn-blue'>
            #{ t('.edit_master_category') }
          </button>

          <button onclick=\"destroy_master_category('#{ master_category.id.to_s }', '#{ master_category.name.to_s }')\"  class='btn'>
            #{ t('.delete_master_category') }
          </button>
        </span>
      </span>"
  end
end
