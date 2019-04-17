import React, { Component } from 'react';
import { RichUtils } from 'draft-js';
import { Button } from 'semantic-ui-react'

export default ({ blockType, children }) => (
  class BlockStyleButton extends Component {

    constructor(props) {
      super(props)

      this.toggleStyle = this.toggleStyle.bind(this)
      this.preventBubblingUp = this.preventBubblingUp.bind(this)
      this.blockTypeIsActive = this.blockTypeIsActive.bind(this)
    }

    toggleStyle(event) {
      event.preventDefault()

      this.props.setEditorState(
        RichUtils.toggleBlockType(
          this.props.getEditorState(),
          blockType
        )
      );
    }

    preventBubblingUp(event) { event.preventDefault() }

    blockTypeIsActive() {
      if (!this.props.getEditorState) {
        return false
      }

      const editorState = this.props.getEditorState();
      const type = editorState
        .getCurrentContent()
        .getBlockForKey(editorState.getSelection().getStartKey())
        .getType()
      return type === blockType
    }

    render() {
      return (
        <Button
          icon
          children={children}
          onClick={this.toggleStyle}
          active={this.blockTypeIsActive()}
        />
      );
    }
  }
);
