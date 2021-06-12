defmodule MilesToGoWeb.Bulma.FormHelpers do
  @moduledoc """
  Helpers for Bulma tags
  """
  alias Phoenix.HTML.Form

  import Phoenix.HTML.Tag
  import MilesToGoWeb.ErrorHelpers

  defp humanize_atom(atom) do
    atom
    |> Atom.to_string()
    |> String.replace("_", " ")
    |> String.capitalize()
  end

  defp input_field_icon(icon) when is_binary(icon) do
    content_tag :span, class: "icon is-small is-left has-text-primary" do
      content_tag :i, class: "fa fa-#{icon}" do
        []
      end
    end
  end

  defp input_field_icon(nil), do: nil

  defp get_error_tag(form, field) do
    error_tag(form, field)
    |> Enum.map(fn error ->
      content_tag :span, class: "help is-danger has-text-centered" do
        error
      end
    end)
  end

  def get_form_input_class(form, field) do
    "input " <> ((form.errors[field] && "is-danger") || "")
  end

  def bulma_form_input(form, field, opts \\ []) do
    class_attr = {:class, opts[:class] || get_form_input_class(form, field)}
    placeholder_attr = {:placeholder, opts[:placeholder] || humanize_atom(field)}
    type = Form.input_type(form, field)
    field_tag = apply(Form, type, [form, field, [class_attr, placeholder_attr]])

    icon = opts[:icon] || ""
    icon_tag = input_field_icon(icon)

    label_tag =
      content_tag :label, class: "label" do
        opts[:placeholder] || humanize_atom(field)
      end

    error_tag = get_error_tag(form, field)

    content_tag :div, class: "field" do
      [
        label_tag,
        content_tag :div, class: "control has-icons-left" do
          [field_tag, icon_tag, error_tag]
        end
      ]
    end
  end

  def bulma_form_submit(label, opts \\ []) do
    class = {:class, opts[:class] || "button is-primary is-fullwidth"}

    content_tag :div, class: "field" do
      apply(Form, :submit, [label, [class]])
    end
  end
end
