local ids, seen = {}, {}

local function pick_id(el)
  if el and el.attr and el.attr.identifier and el.attr.identifier ~= "" then
    return el.attr.identifier
  end
  if el and el.attributes and el.attributes["id"] then
    return el.attributes["id"]
  end
  return nil
end

function Link(el)
  local id = pick_id(el)
  if id and not seen[id] then
    table.insert(ids, id)
    seen[id] = true
  end
  return el
end

function Pandoc(doc)
  if #ids == 0 then return doc end
  local out = {"<style>"}
  for _, id in ipairs(ids) do
    table.insert(out, string.format(
      'body:has(a#%s:hover),\nbody:has(a#%s:focus-visible){background-image:url("screens/%s.png");background-size:128px;}',
      id, id, id
    ))
  end
  table.insert(out, "</style>")
  table.insert(doc.blocks, 1, pandoc.RawBlock("html", table.concat(out, "\n")))
  return doc
end
