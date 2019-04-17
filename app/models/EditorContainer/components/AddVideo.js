import React, {Component} from 'react'
import { Button, Icon, Modal, Header, Form } from 'semantic-ui-react'

const initialState = {
  url: 'https://www.youtube.com/watch?v=j2YgDua2gpk',
  modalOpen: false
}

export default class AddVideo extends Component {
  constructor(props) {
    super(props)

    this.state = initialState

    this.openModal = this.openModal.bind(this)
    this.closeModal = this.closeModal.bind(this)
    this.onChange = this.onChange.bind(this)
    this.onSave = this.onSave.bind(this)
  }

  onSave(evt) {
    const { url } = this.state
    const { editorState, onChange, modifier } = this.props;

    this.setState(initialState);

    onChange(modifier(editorState, { src: url }));
  }

  onChange(evt) {
    this.setState({url: evt.target.value})
  }

  openModal() {
    this.setState({modalOpen: true})
  }

  closeModal() {
    this.setState({modalOpen: false})
  }

  render() {
    const {url, modalOpen} = this.state
  
    return (
      <Modal open={modalOpen} size="tiny" trigger={
        <Button icon onClick={this.openModal}>
          <Icon name="video" />
        </Button>
      }>
        <Modal.Content>
          <Modal.Description>
            <Header>Add Video</Header>
            <Form>
              <Form.Field>
                <label>Video URL:</label>
                <input name="url" onChange={this.onChange} value={url} />
              </Form.Field>
            </Form>
          </Modal.Description>
        </Modal.Content>
        <Modal.Actions>
          <Button onClick={this.closeModal} primary>
            Cancel
          </Button>
          <Button primary onClick={this.onSave}>
            Save
          </Button>
        </Modal.Actions>
      </Modal>
    )
  }
}