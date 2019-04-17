import React, { Component } from 'react'

import { EditorState, ContentState, convertToRaw, convertFromRaw, convertFromHTML } from 'draft-js'
import Editor, { composeDecorators } from 'draft-js-plugins-editor'
import { Button, Icon } from 'semantic-ui-react'

import 'draft-js-image-plugin/lib/plugin.css'
import 'draft-js-video-plugin/lib/plugin.css'
import 'draft-js-focus-plugin/lib/plugin.css'
import 'draft-js-linkify-plugin/lib/plugin.css'

import createImagePlugin from 'draft-js-image-plugin'
import createVideoPlugin from 'draft-js-video-plugin'
import createFocusPlugin from 'draft-js-focus-plugin'
import createSideToolbarPlugin from 'draft-js-side-toolbar-plugin'
import createLinkPlugin from 'draft-js-anchor-plugin'
import createDividerPlugin from 'draft-js-divider-plugin'
import createInlineToolbarPlugin from 'draft-js-inline-toolbar-plugin'

import buttonStyles from 'draft-js-anchor-plugin/lib/plugin.css'
import createAlignPlugin from './components/plugins/alignPlugin'

import toolbarStyles from './components/InlineToolbar.css'
import blockTypeSelectStyles from './components/blockTypeSelectStyles.css'

import * as array from '../../../util/array'

import AddImage from './components/AddImage'
import AddVideo from './components/AddVideo'
import { uploadImage } from '../api'

import s from './index.scss'
import linkStyles from './linkStyles.css'

import createBlockStyleButton from './utils/createBlockStyleButton'
import createInlineStyleButton from './utils/createInlineStyle'

const BoldButton = createInlineStyleButton({
  style: 'BOLD',
  children: <Icon name="bold" />,
})

const ItalicButton = createInlineStyleButton({
  style: 'ITALIC',
  children: <Icon name="italic" />,
})

const QuoteButton = createBlockStyleButton({
  blockType: 'blockquote',
  children: <Icon name="quote left" />
})

const HeadingButton = createBlockStyleButton({
  blockType: 'header-three',
  children: <Icon name="header" />
})

const inlineToolbarTheme = {
  toolbarStyles: {
    toolbar: {
      border: 'none',
      background: 'transparent'
    }
  }
}

const videoPlugin = createVideoPlugin()
const focusPlugin = createFocusPlugin()

const alignPlugin = createAlignPlugin()
const linkPlugin = createLinkPlugin({
  theme: linkStyles
})

const inlineToolbarPlugin = createInlineToolbarPlugin({
  theme: { toolbarStyles, buttonStyles }
})
const decorator = composeDecorators(
  focusPlugin.decorator,
  alignPlugin.decorator
)
const dividerPlugin = createDividerPlugin({ decorator })
const imagePlugin = createImagePlugin({ decorator })
const { DividerButton } = dividerPlugin
const sideToolbarPlugin = createSideToolbarPlugin({
  position: 'right',
  theme: { buttonStyles, toolbarStyles, blockTypeSelectStyles }
})
const { SideToolbar } = sideToolbarPlugin

const plugins = [imagePlugin, videoPlugin, focusPlugin, alignPlugin, inlineToolbarPlugin, linkPlugin, dividerPlugin, sideToolbarPlugin]

const { AlignmentTool } = alignPlugin
const { InlineToolbar } = inlineToolbarPlugin

const convertContent = (content) => {
  let state
  if (array.isJson(content)) {
    state = convertFromRaw(JSON.parse(content))
  } else {
    const blocksFromHTML = convertFromHTML(content)
    state = ContentState.createFromBlockArray(
      blocksFromHTML.contentBlocks,
      blocksFromHTML.entityMap
    )
  }
  return EditorState.createWithContent(state)
}

export default class DraftEditor extends Component {
  constructor(props) {
    super(props)
    const content = this.props.content ? this.props.content : (this.props.article ? this.props.article.content : '')
    let initialContent = EditorState.createEmpty()

    if (content) {
      initialContent = (content !== '') ? convertContent(content) : EditorState.createEmpty()
    }

    this.state = {
      editorState: initialContent
    }

    this.onChange = this.onChange.bind(this)
    this.updateContent = this.updateContent.bind(this)
  }

  onChange(editorState) {
    this.setState({ editorState }, () => this.updateContent())
  }

  focus = () => {
    this.editor.focus()
  }

  addNewImage = (data) => {
    this.setState(() => ({ uploadingImage: true }))

    uploadImage(this.props.article.id, data)
      .then((image) => {
        const url = `http:${image.url}`
        this.onChange(imagePlugin.addImage(this.state.editorState, url))
      })
  }

  updateContent() {
    const { editorState } = this.state
    const content = convertToRaw(editorState.getCurrentContent())
    this.props.updateArticle({ content: JSON.stringify(content) })
  }

  render() {
    let addMedia = null

    if (this.props.resourceName === 'Article') {
      addMedia = (
        <div>
          <AddImage
            editorState={ this.state.editorState }
            onChange={ this.onChange }
            modifier={ imagePlugin.addImage }
            addNewImage={ this.addNewImage }
          />
          <AddVideo
            editorState={ this.state.editorState }
            onChange={ this.onChange }
            modifier={ videoPlugin.addVideo }
          />
        </div>
      )
    }
    return (
      <div className={ s.EditorContainer } onClick={ this.focus }>
        {addMedia}
        <div className={ s.Editor }>
          <Editor
            plugins={ plugins }
            editorState={ this.state.editorState }
            onChange={ this.onChange }
            ref={ (element) => { this.editor = element } }
          />
          <AlignmentTool />
          <InlineToolbar theme={ inlineToolbarTheme }>
            {(externalProps) => (
              <Button.Group onMouseDown={ (evt) => evt.preventDefault() }>
                <HeadingButton { ...externalProps } />
                <BoldButton { ...externalProps } />
                <ItalicButton { ...externalProps } />
                <QuoteButton { ...externalProps } />
                <linkPlugin.LinkButton { ...externalProps } />
                <DividerButton { ...externalProps } />
              </Button.Group>
            )}
          </InlineToolbar>
        </div>
      </div>
    )
  }
}
