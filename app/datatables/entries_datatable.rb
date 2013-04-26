class EntriesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Entry.count,
      iTotalDisplayRecords: entries.total_entries,
      aaData: data
    }
  end

private

  def data
    entries.map do |entry|
      [
        entry.term,
        entry.definition,
        entry.translation,
        "#{link_to('View/Edit', entry)} | #{link_to 'Delete', entry, :confirm => 'Are you sure?', :method => :delete}"
      ]
    end
  end

  def entries
    @entries ||= fetch_entries
  end

  def fetch_entries
    entries = Entry.order("#{sort_column} #{sort_direction}")
    entries = entries.page(page).per_page(per_page)
    if params[:sSearch].present?
      entries = Entry.search("#{params[:sSearch]}*", :page=>page)
    end
    entries
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[term definition translation]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end