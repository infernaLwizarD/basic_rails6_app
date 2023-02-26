module LteHelper
  def lte_button_to(options)
    options[:text] ||= ''
    options[:path] ||= '#'
    options[:class] ||= 'btn-default'

    if options[:method].present?
      link_to(options[:text], options[:path], method: options[:method], class: "btn #{options[:class]}").html_safe
    else
      link_to(options[:text], options[:path], class: "btn #{options[:class]}").html_safe
    end
  end

  def draw_main_title(options = {})
    options[:title] ||= ''
    options[:size] ||= 1

    %(
      <section class="content-header"> \
      <div class="container-fluid"> \
          <div class="row mb-2"> \
              <div class="col-sm-6"> \
                  <h#{options[:size]}>#{options[:title]}</h#{options[:size]}> \
              </div> \
              <div class="col-sm-6"></div> \
          </div> \
      </div> \
      </section> \
    ).html_safe
  end

  ###--Кнопки--###
  def draw_edit_button(options)
    disabled = options[:disabled].present? ? ' disabled' : ''
    link_to(icon('fas', 'edit', 'Редактировать'), options[:path], class: "btn btn-primary#{disabled}")
  end

  def draw_back_button(options)
    disabled = options[:disabled].present? ? ' disabled' : ''
    link_to(icon('fas', 'arrow-left', 'Назад'), options[:path], class: "btn btn-secondary#{disabled}")
  end

  def draw_delete_button(options)
    disabled = options[:disabled].present? ? ' disabled' : ''
    options[:confirm_text] ||= 'Вы уверены?'
    link_to(icon('fas', 'trash-alt', 'Удалить'), options[:path], method: :delete,
                                                                 data: { confirm: options[:confirm_text] },
                                                                 class: "btn btn-danger float-right#{disabled}")
  end

  def draw_save_button(options = {})
    # для кнопки за пределами формы необходимы параметры type="button", onclick="submit()"
    options[:type] ||= 'submit'
    options[:name] ||= 'button'
    form = options[:form].present? ? %( form="#{options[:form]}") : ''
    id = options[:id].present? ? %( id="#{options[:id]}") : ''
    disabled = options[:disabled].present? ? ' disabled' : ''
    onclick = options[:onclick].present? ? %( onclick="#{options[:onclick]}" ) : ''

    out = %(
            <button type="#{options[:type]}" class="btn btn-success float-right"#{form}#{id} name="#{options[:name]}"
            #{onclick}#{disabled}><i class="fas fa-save"></i> Сохранить</button>
    )
    out.html_safe
  end

  def draw_new_button(options)
    options[:label] ||= 'Добавить'
    options[:bg_class] ||= 'btn-light'
    options[:icon] ||= 'plus'
    disabled = options[:disabled].present? ? ' disabled' : ''

    if options[:button].present?
      %(
      #{link_to(%(
          <button type="button" class="btn btn-sm #{options[:bg_class]}">
            #{icon('fas', options[:icon], options[:label])}
          </button>
        ).html_safe, options[:path])}
      ).html_safe
    else
      link_to(icon('fas', options[:icon], options[:label]), options[:path],
              class: "btn #{options[:bg_class]} btn-sm#{disabled}")
    end
  end
  ###----###
end
