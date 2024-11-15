defmodule GildedRose do
  # Función que actualiza la calidad de los items
  def update_item(item) do
    update_item_by_name(item)
  end

  # Guard para manejar Aged Brie
  defp update_item_by_name(%{name: "Aged Brie"} = item) do
    update_aged_brie(item)
  end

  # Guard para manejar Backstage passes
  defp update_item_by_name(%{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    increment_backstage_quality(item)
  end

  # Guard para manejar Sulfuras
  defp update_item_by_name(%{name: "Sulfuras, Hand of Ragnaros"} = item) do
    item
  end

  # Guard para manejar Conjured
  defp update_item_by_name(%{name: "Conjured"} = item) do
    update_conjured_item(item)
  end

  # Guard para manejar items normales
  defp update_item_by_name(item) do
    update_normal_item(item)
  end

  # Actualización para Aged Brie
  defp update_aged_brie(%{quality: quality, sell_in: sell_in} = item) when sell_in <= 0 do
    new_quality = min(50, quality + 2)
    %{item | quality: new_quality, sell_in: sell_in - 1}
  end

  defp update_aged_brie(%{quality: quality, sell_in: sell_in} = item) when sell_in > 0 do
    new_quality = min(50, quality + 1)
    %{item | quality: new_quality, sell_in: sell_in - 1}
  end

  # Incrementa la calidad de Backstage passes con guardas
  defp increment_backstage_quality(%{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in, quality: quality} = item)
       when sell_in <= 0 do
    %{item | quality: 0, sell_in: sell_in - 1}
  end

  defp increment_backstage_quality(%{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in, quality: quality} = item)
       when sell_in <= 5 do
    new_quality = min(50, quality + 3)
    %{item | quality: new_quality, sell_in: sell_in - 1}
  end

  defp increment_backstage_quality(%{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in, quality: quality} = item)
       when sell_in <= 10 do
    new_quality = min(50, quality + 2)
    %{item | quality: new_quality, sell_in: sell_in - 1}
  end

  defp increment_backstage_quality(%{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in, quality: quality} = item) do
    new_quality = min(50, quality + 1)
    %{item | quality: new_quality, sell_in: sell_in - 1}
  end

  # Actualiza los items Conjured
  defp update_conjured_item(%{quality: quality, sell_in: sell_in} = item) do
    new_quality = max(0, quality - 2)
    %{item | quality: new_quality, sell_in: sell_in - 1}
  end

  # Actualiza items normales
  defp update_normal_item(%{quality: quality, sell_in: sell_in} = item) do
    new_quality = max(0, quality - 1)
    %{item | quality: new_quality, sell_in: sell_in - 1}
  end
end
