export function authorPrettyTitle (author = {}) {
  if (!author?.aid) return ''
  return author.altname
    ? author.altname
    : author.name + ' ' + author.surname
}

export function authorPrettyFeaturing (featsArr = []) {
  if (!featsArr.length) return []
  const feats = []
  featsArr = featsArr.sort((f1, f2) => f1.position - f2.position)
  featsArr.forEach((feat) => {
    feats.push(feat.artist)
  })
  return feats
}
