defmodule GildedRose do
  # Función que actualiza la calidad de los items
  def update_item(item) do
    cond do
      item.name == "Aged Brie" -> 
        update_aged_brie(item)

      item.name == "Backstage passes to a TAFKAL80ETC concert" -> 
        increment_backstage_quality(item)

      item.name == "Sulfuras, Hand of Ragnaros" -> 
        item

      item.name == "Conjured" -> 
        update_conjured_item(item)

      true -> 
        update_normal_item(item)
    end
  end

  # Actualización para Aged Brie
  defp update_aged_brie(%{quality: quality, sell_in: sell_in} = item) do
    new_quality =
      if sell_in <= 0 do
        # Incrementa la calidad en 2 si sell_in es menor o igual a 0
        min(50, quality + 2)
      else
        # Incrementa la calidad en 1 si sell_in es mayor a 0
        min(50, quality + 1)
      end

    # Regresa el nuevo item con la calidad actualizada y el sell_in decrecido
    %{item | quality: new_quality, sell_in: sell_in - 1}
  end

  # Incrementa la calidad de Backstage passes
  defp increment_backstage_quality(%{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in, quality: quality} = item) do
    new_quality =
      cond do
        sell_in <= 0 -> 0
        sell_in <= 5 -> min(50, quality + 3)
        sell_in <= 10 -> min(50, quality + 2)
        true -> min(50, quality + 1)
      end

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
